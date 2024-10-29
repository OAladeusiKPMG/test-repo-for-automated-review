//References
const express = require("express");
const tb = require("../components/utils/toolbox");
const errorHandler = require("../components/errorHandler");
const jwt = require("jsonwebtoken");
const bcrypt = require('bcryptjs');
//Models import
const models = require("../server/models/index");
//
const { Op } = require('sequelize');
//Instantiations
//Instantiate express router
const router = express.Router();
//other dependencies
//expres validator
const { check, validationResult } = require("express-validator");
const config = require("../config");

//model utility functions
const Repository = require("../repository/user.repository");

//API endpoint list

//User onboarding endpoints
//Anonymous endpoint

//Generate access token  for user
router.post("/login", async (req, res, next) => {
  //connect to database and perform neccessary user existence verification.
  try {
    let user = await models.User.findOne({
      where: { isDeleted: 0,username: req.body.username},
    });

    if (user == null) {
      //profile user
      const theStaff = await models.Staff.findOne({
        where: { username: req.body.username },
      });


      const createdUser = await Repository.insertUser({
        username: theStaff.username,
        email: theStaff.email,
        name: theStaff.displayName,
        unit: theStaff.unit,
        jobTitle: theStaff.jobTitle,
        roleId: config.roleIds.staff,
      });

      console.log(req.body.username)
      user = createdUser;
      console.log(createdUser);
    }
    //get user role name

    if (user == null) {
      tb.responsify(
        res,
        400,
        "Unable to validate your identity. Please contact the administrator.",
        null
      );
    } else {

      //check password 
      // console.log(config.dsp, JSON.stringify(user))
      const isPasswordCorrect= await bcrypt.compare(config.dsp, user.password);

      if(!isPasswordCorrect){throw {message:config.RESPONSE_MESSAGES.WRONG_PASSWORD, code:config.HTTP_CODES.BAD_REQUEST}};

      const userRole = await models.UserRole.findOne({
        where: { userId: user.id },
      });
      const role = await models.Role.findOne({
        where: { id: userRole.roleId },
      });

      const expiresIn = "1h";
      const { password, ...userWithoutPass } = user.get();
      const user_with_role = {
        ...userWithoutPass,
        role: role.name,
        roleId: role.id,
      };

      jwt.sign(
        { user: user_with_role },
        "MyCustomEncryptionSecretKey",
        { expiresIn },
        (err, token) => {
          if (err) {
            errorHandler.dispatchInternalServerError(res, err);
          } else {
            const responseData = {
              access_token: token,
              expiresIn: expiresIn,
              username: user.username,
              email: user.email,
              firstName:user.firstName,
              lastName:user.lastName,
              unit: user.unit,
              division:user.division,
              role: tb.removeUnderScoreFromText(role.name),
              jobTitle: user.jobTitle,
              profilePicture: user.profilePicture,
            };
            // const responseData = { access_token: token};
            tb.responsify(res, 200, "", responseData);
          }
        }
      );


    }
  } catch (err) {
    errorHandler.dispatchNotFoundError(
      res,
      "Unable to validate your identity. Please contact the administrator.",
      "Invalid login attempt. Incorrect username or password. " + JSON.stringify(err)
    );
  }
});

router.delete("/logout", tb.jwtAuthorize, () => {
  tb.responsify(
    res,
    200,
    "To logout, please delete the access token from user's client. token also expires after 1hr",
    null
  );
});

//Create
router.post("/registerUser", async (req, res, next) => {
  try {
    const rb = req.body;
    let newUserData = {
      username: rb.username,
      email: rb.email,
      name: rb.name,
      unit: rb.unit,
      roleId: rb.roleId,
      profilePicture:
        "https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=" +
        rb.email +
        "&UA=0&size=HR96x96"
    };

    // check if user already exist
    const userExist = await models.User.findOne({
      where: { email: newUserData.email },
    });
    if (userExist) {
      tb.responsify(res, 500, "Account already profiled.", [newUserData]);
    } else {
      //first get staff other profile
      const staff = await models.Staff.findOne({
        where: { email: newUserData.email },
      });
      //profile the user
      const result = await models.User.create({
        profilePicture: newUserData.profilePicture,
        username: newUserData.username,
        password: "Password12*",
        firstName: staff.firstName,
        lastName: staff.lastName,
        email: newUserData.email,
        division: staff.division,
        unit: staff.unit,
        isDeleted: 0
      });

      //add user to role
      const roleResult = await models.UserRole.create({
        userId: result.id,
        roleId: newUserData.roleId,
      });

      //getrole
      const role = await models.Role.findOne({
        where: { id: newUserData.roleId },
      });

      tb.responsify(res, 200, "account successfully created", {
        ...newUserData,
        role: tb.removeUnderScoreFromText(role.name),
      });
    }
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

//Read
// Get all users
router.get("/getAllUsers", tb.jwtAuthorize, async (req, res, next) => {
  try {
    //take to function
    let perPage = Number(
      typeof req.query.perPage == "undefined" ? 10000 : req.query.perPage
    );
    const page = req.query.page ? Number(req.query.page) : 1;   
    const users = await models.User.findAll({
      where: { isDeleted: false },
      offset:(page-1)*perPage,
      limit:perPage,
    });
    let total= (await models.User.findAll({
      where: { isDeleted: false },
    })).length;
    //console.log(users)
    const paginated = await tb.paginateArray(users,total, page, perPage);

    //get roles of users
    const paginatedUserListWithRole = [];
    let i = 0;
    paginated.data.forEach(async (elem, index) => {
      // console.log(elem)
      const getRoleObject = async (elem) => {
        //console.log(elem)
        const userRole = await models.UserRole.findOne({
          where: { userId: elem.id },
        });
        const role = await models.Role.findOne({
          where: { id: userRole.roleId },
        });
        return {
          roleId: role.id,
          role: tb.removeUnderScoreFromText(role.name),
        };
      };
      const roleObject = await getRoleObject(elem);
      paginatedUserListWithRole.push({ ...elem.dataValues, ...roleObject });
      //console.log(paginatedUserListWithRole)
      i++;
      if (i === paginated.data.length) {
        let newpaginated = paginated;
        newpaginated.data = paginatedUserListWithRole;
        tb.responsify(res, 200, "success", newpaginated);
      }
    });
    //get roles of users
    //take to functionn
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

// Get all users
router.get("/search", tb.jwtAuthorize, async (req, res, next) => {
  try {
    //take to function
    let perPage = Number(
      typeof req.query.perPage == "undefined" ? 10 : req.query.perPage
    );
    const page = req.query.page ? Number(req.query.page) : 1;
    const searchKey = req.query.keyword;
    const users = await models.User.findAll({
      where: { isDeleted: false, username: {
        [Op.like]: `%${searchKey}%`
      } },
    });
    //console.log(users)
    const paginated = await tb.paginateArray(users, page, perPage);

    //get roles of users
    const paginatedUserListWithRole = [];
    let i = 0;
    paginated.data.forEach(async (elem, index) => {
      // console.log(elem)
      const getRoleObject = async (elem) => {
        //console.log(elem)
        const userRole = await models.UserRole.findOne({
          where: { userId: elem.id },
        });
        const role = await models.Role.findOne({
          where: { id: userRole.roleId },
        });
        return { roleId: role.id, role: role.name };
      };
      const roleObject = await getRoleObject(elem);
      paginatedUserListWithRole.push({ ...elem.dataValues, ...roleObject });
      console.log(paginatedUserListWithRole);
      i++;
      if (i === paginated.data.length) {
        tb.responsify(res, 200, "success", paginatedUserListWithRole);
      }
    });
    //get roles of users
    //take to functionn
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});


// Get all users
router.get("/filterByUnit", tb.jwtAuthorize, async (req, res, next) => {
  try {
    //take to function
    let perPage = Number(
      typeof req.query.perPage == "undefined" ? 10 : req.query.perPage
    );
    const page = req.query.page ? Number(req.query.page) : 1;
    const unit = req.query.unit.toLowerCase();
    const users = await models.User.findAll({
      include :{
        model:models.UserRole,
        as:"userRole",
        include:{
          model:models.Role,
          as:"role"
        }
      },
      where: { isDeleted: false, unit: {
        [Op.like]: `%${unit}%`
      } }
    });
    //console.log(users)
    const paginated = await tb.paginateArray(users, page, perPage);

    //get roles of users
    const paginatedUserListWithRole = [];
    let i = 0;
    paginated.data.forEach(async (elem, index) => {
      // console.log(elem)
      const getRoleObject = async (elem) => {
        //console.log(elem)
        const userRole = await models.UserRole.findOne({
          where: { userId: elem.id },
        });
        const role = await models.Role.findOne({
          where: { id: userRole.roleId },
        });
        return { roleId: role.id, role: role.name };
      };
      const roleObject = await getRoleObject(elem);
      paginatedUserListWithRole.push({ ...elem.dataValues, ...roleObject });
      console.log(paginatedUserListWithRole);
      i++;
      if (i === paginated.data.length) {
        tb.responsify(res, 200, "success", paginatedUserListWithRole);
      }
    });
    //get roles of users
    //take to functionn
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});


router.get("/getUser", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const userId = req.query.userId;
    const user = await models.User.findOne({
      include :{
        model:models.UserRole,
        as:"userRole",
        include:{
          model:models.Role,
          as:"role"
        }
      },
      where: { id: userId },
    });
    tb.responsify(res, 200, "success", user);
  } catch (error) {
    errorHandler.dispatchInternalServerError(res, error);
  }
});

router.get("/getUserByUserName", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const username = req.query.username;
    const user = await models.User.findOne({
      include :{
        model:models.UserRole,
        as:"userRole",
        include:{
          model:models.Role,
          as:"role"
        }
      },
      where: { username:username },
    });
    tb.responsify(res, 200, "success", user);
  } catch (error) {
    errorHandler.dispatchInternalServerError(res, error);
  }
});
//Roles

router.get("/getAllRoles", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const roleList = await models.Role.findAll({ attributes: ["id", "name"] });

    let newRoleList = [];
    roleList.map((item, index) => {
      newRoleList.push({
        id: item.id,
        name: tb.removeUnderScoreFromText(item.name),
      });
    });
    //newRoleList.push(tb.removeUnderScoreFromText("aladeusi_olugbenga"));
    tb.responsify(res, 200, "success", newRoleList);
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

//Update
router.post("/updateUserRole", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const { userId, newRoleId } = req.body;
    //perform paramater validation
    //update user's role
    const updated = await models.UserRole.update(
      { roleId: newRoleId },
      { where: { userId: userId } }
    );

    let result = await Repository.getUsersFromDB(1, 10, true, userId);
    let user = { ...result[0] };
    tb.responsify(res, 200, "success", user);
  } catch (err) {
    // console.log(err)
    errorHandler.dispatchInternalServerError(res, err);
  }
});

router.put("/updateUserProfile", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const userId = Number(req.query.userId);
    const { firstName, lastName } = req.body;
    //perform paramater validation
    //update user's role

    if (req.query.userId) {
      if (typeof firstName === "undefined" || typeof lastName === "undefined") {
        tb.responsify(
          res,
          400,
          "Both firstName ands lastName are required",
          null
        );
      } else {
        const updated = await models.User.update(
          { firstName: firstName, lastName: lastName },
          { where: { id: userId } }
        );
        tb.responsify(res, 200, "success", null);
      }
    } else {
      tb.responsify(res, 400, "userId is required", null);
    }
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

//Delete
router.delete("/deleteUser", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const { userId } = req.query;
    const updated = await models.User.update(
      { isDeleted: 1 },
      { where: { userId: userId } }
    );
    // let result = await Repository.getUsersFromDB(1, 10, true, userId);
    // let user = { ...result[0] }
    tb.responsify(res, 200, "User successfully deleted");
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

//export Router object to make it publicly accessible
module.exports = router;
