//References
const tb = require("../components/utils/toolbox");
const bcrypt = require('bcryptjs');
//Models import
const models = require("../server/models/index");

const config= require("../config")

const insertUser = async (user) => {
  try {
    const rb = user;
    let newUserData = {
      username: rb.username,
      email: rb.email,
      name: rb.name,
      unit: rb.unit,
      division:rb.division,
      jobTitle:rb.jobTitle,
      roleId:rb.roleId,
      profilePicture:
        "https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=" +
        rb.email +
        "&UA=0&size=HR96x96",
    };
    //first get staff other profile
    const staff = await models.Staff.findOne({
      where: { email: newUserData.email },
    });
    //profile the user
     //hash password
     const saltRounds = 10;
     const hashedPassword = bcrypt.hashSync(config.dsp, saltRounds);
     //set hashed password
     newUserData.password=hashedPassword;

    const result = await models.User.create({
      profilePicture: newUserData.profilePicture,
      username: newUserData.username,
      password: newUserData.password,
      firstName: staff.firstName,
      lastName: staff.lastName,
      email: newUserData.email,
      division: staff.division,
      jobTitle:staff.jobTitle,
      unit: staff.unit,
      isDeleted: 0,
    });
    //add user to role
    const roleResult = await models.UserRole.create({
      userId: result.id,
      roleId: newUserData.roleId,
    });
    return result;
  } catch (err) {
    return null;
  }
};

const getUsersFromDB = async (page, perPage, getOne = false, userId = null) => {
  perPage = Number(typeof perPage == "undefined" ? 10 : perPage);
  page = Number(page);

  const users = [];

  if (getOne == true) {
    const user = await models.User.findOne({
      where: { id: userId, isDeleted: false },
    });
    users.push(user);
  } else {
    users = await models.User.findAll({ where: { isDeleted: false } });
  }
  //console.log(users)
  const paginated = await tb.paginateArray(users, page, perPage);

  //get roles of users
  const paginatedUserListWithRole = [];
  let i = 0;

  for (let i_d = 0; i_d <= paginated.data.length; i_d++) {
    // console.log(elem)

    let elem = paginated.data[i_d];
    const getRoleObject = async (elem) => {
      //console.log(elem)
      const userRole = await models.UserRole.findOne({
        where: { userId: elem.id },
      });
      const role = await models.Role.findOne({
        where: { id: userRole.roleId },
      });
      return { roleId: role.id, role: tb.removeUnderScoreFromText(role.name) };
    };

    const roleObject = await getRoleObject(elem);
    paginatedUserListWithRole.push({ ...elem.dataValues, ...roleObject });
    console.log(paginatedUserListWithRole);
    i++;
    if (i === paginated.data.length) {
      return paginatedUserListWithRole;
    }
  }
};

module.exports = {
  insertUser,
  getUsersFromDB,
};
