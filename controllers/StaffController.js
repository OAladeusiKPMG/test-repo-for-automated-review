//References
const express = require("express");
const tb = require("../components/utils/toolbox");
const errorHandler = require("../components/errorHandler");
const jwt = require("jsonwebtoken");
//Models import
const models = require("../server/models/index");
//Instantiations
//Instantiate express router
const router = express.Router();
//other dependencies
const { Op } = require('sequelize');
const config=require("../config");
const path = require('path');
const moment = require("moment/moment");

//cron utility functions
const utility = require("../utils/utils");

const cardRepository= require("../repository/card.repository")


//API endpoint list

// Get all users - paginated
router.get("/getAllStaffPaginated", async (req, res, next) => {
    try {
        let perPage = Number((typeof req.query.perPage == "undefined") ? 10 : req.query.perPage);
        const page = Number(req.query.page);
        // const staffList = await models.Staff.findAll({ where: { status: 1 } });
        let staffList = await models.Staff.findAll();
        staffList= staffList.reverse()
        //console.log(users)
        const paginated = await tb.paginateArray(staffList, page, perPage)

        tb.responsify(res, 200, "success", paginated)

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});


// Get all users - no paging
router.get("/getAllStaff", async (req, res, next) => {
    try {
        // const staffList = await models.Staff.findAll({ where: { status: 1 } });
        let staffList = await models.Staff.findAll();
        staffList= staffList.reverse()

        tb.responsify(res, 200, "success", staffList)

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});

router.get("/getStaffEmailList", async (req, res, next) => {
    try {
        const staffEmailList = await models.Staff.findAll({ attributes: ['email'], where: { status: 1 } });
        const Emails = [];
        let i;
        for (i = 0; i < staffEmailList.length; i++) {

            Emails.push(staffEmailList[i].email);
            if (i === staffEmailList.length - 1) {
                tb.responsify(res, 200, "success", Emails)
            }
        }


    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});


router.get("/getStaffProfileByEmail", async (req, res, next) => {
    try {
        if (req.body.email) {
            const email = decodeURIComponent(req.body.email);
            const staff =await models.Staff.findOne({ where: { email } })
            tb.responsify(res, 200, "success", [staff]);
        } else {
            errorHandler.dispatchBadRequestError(res, "url encoded email not specified", null)
        }

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});


router.get("/getStaffProfileByEmail2", async (req, res, next) => {
    try {
        if (req.query.email) {
            const email = decodeURIComponent(req.query.email);
            const staff =await models.Staff.findOne({ where: { email } })
            tb.responsify(res, 200, "success", [staff]);
        } else {
            errorHandler.dispatchBadRequestError(res, "url encoded email not specified", null)
        }

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});




router.get("/getStaffProfileById", async (req, res, next) => {
    try {
        if (req.query.staffId) {
            const staffId =Number(req.query.staffId);
            const staff =await models.Staff.findByPk(staffId)
            tb.responsify(res, 200, "success", [staff]);
        } else {
            errorHandler.dispatchBadRequestError(res, "staffId not specified", null)
        }

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});


router.get("/getStaffProfileByUsername", async (req, res, next) => {
    try {
        if (req.query.username) {
            const username =req.query.username;
            const staff =await models.Staff.findOne({where:{username:username}})
            tb.responsify(res, 200, "success", [staff]);
        } else {
            errorHandler.dispatchBadRequestError(res, "username not specified", null)
        }
 
    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});



router.get("/search", tb.jwtAuthorize, async (req, res, next) => {
    try {
      //take to function
      let perPage = Number(
        typeof req.query.perPage == "undefined" ? 10 : req.query.perPage
      );
      const page = req.query.page ? Number(req.query.page) : 1;
      const searchKey = req.query.keyword;
      const staff = await models.Staff.findAll({
        where: {
            [Op.or]:[
                { firstName :{ [Op.like]: "%" + searchKey+"%"  } },
                { displayName :{ [Op.like]: "%" + searchKey+"%"  } },
                { lastName :{ [Op.like]: "%" + searchKey+"%"  } },
                { username :{ [Op.like]: "%" + searchKey+"%"  } },
                { email :{ [Op.like]: "%" + searchKey+"%"  } }
            ]
               
             },
      });
      //console.log(users)
      const paginated = await tb.paginateArray(staff, page, perPage);
      tb.responsify(res, 200, "success", paginated);
  
      //take to functionn
    } catch (err) {
      errorHandler.dispatchInternalServerError(res, err);
    }
  });



  router.get("/downloadStaffListTemplate", tb.jwtAuthorize, async (req, res, next) => {
   
    try {

        //request parameter validation
 
        let {fileType}=req.query;
        let fileExtension;
        switch(fileType){
            case config.fileExtensions.csv:
                fileExtension=config.fileExtensions.csv;
                break;
            case config.fileExtensions.exelXLS:
                fileExtension=config.fileExtensions.exelXLS;
                break;
            case config.fileExtensions.exelXLSX:
                fileExtension=config.fileExtensions.exelXLSX;
                break;
            default:
                fileExtension=config.fileExtensions.exelXLSX;
                break;
        }
        const fileHTTPPath=`${config.BaseUrl}${config.uploadPaths.staffListTemplateURL}.${fileExtension}`;
        const data={url:fileHTTPPath};
        tb.responsify(res, 200, "success", data);

    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err);
    }
})
    


//upload employee data
  router.post("/uploadStaffList", tb.jwtAuthorize, async (req, res, next) => {
    try {
     

        let {staffListInBase64, fileType}=req.body;
            //upload staffList
            let fileExtension;
            switch(fileType){
                case config.fileExtensions.csv:
                    fileExtension=config.fileExtensions.csv;
                    break;
                case config.fileExtensions.exelXLS:
                    fileExtension=config.fileExtensions.exelXLS;
                    break;
                case config.fileExtensions.exelXLSX:
                    fileExtension=config.fileExtensions.exelXLSX;
                    break;
                default:
                    fileExtension=config.fileExtensions.csv;
                    break;
            }

            let staffListNewName=await tb.generateRandomNumberString(20);
            staffListNewName= `${staffListNewName}.${fileExtension}`
            let staffListPath=path.join(path.resolve(config.uploadPaths.staffListRelativePath),staffListNewName)
            let status=await tb.uploadBase64File(staffListPath, staffListInBase64);
            let staffList_= await tb.convertExcelAndCvsToJson(staffListPath, fileExtension)

            //iterate and update

            for (const item of staffList_.jsonResult){
                let staff ={

                    firstName:item["FirstName"],
                    lastName:item["LastName"],
                    email:item["EmailAddress"],
                    birthDay:item["Birthday"],
                    status:0
                }
                
                
                if(staff.birthDay.toLowerCase()==""){continue;}
                if(staff.birthDay.toLowerCase().includes("exited")){continue;}
                if(staff.birthDay.toLowerCase().includes(`n/a`)){staff.birthDay=null;}


                const staffExist = await models.Staff.count({where:{
                    email:staff.email
                }});

                //add year to birthday

                //serialize old bith date format to new format
                if(staff.birthDay.includes(".")){
                    staff.birthDay=moment(staff.birthDay, 'MMM.DD').format("DD/MM")
                }else if(staff.birthDay.includes("-")){
                    staff.birthDay=moment(staff.birthDay, 'DD-MMM').format("DD/MM")
                }

                bd=staff.birthDay.split(`/`);
                staff.birthDay=bd.length<=2?`${staff.birthDay}/2022`:staff.birthDay;

                if(staffExist>0){
                    //update birthday only
                    //convert birthday to date
                    staff.birthDay=(staff.birthDay==null)?null: moment(staff.birthDay, 'DD/MM/YYYY');
                    let updated=await models.Staff.update(
                        {firstName:staff.firstName, lastName:staff.lastName, birthDay:staff.birthDay},
                        {where:{email:staff.email}}
                        );
                }else{
                    //create new record
                    staff.birthDay=(staff.birthDay==null)?null: moment(staff.birthDay, 'DD/MM/YYYY');
                    let created=await models.Staff.create(staff);
                }
            }

      tb.responsify(res, 200, "success", null);
  
      //take to functionn
    } catch (err) {
      errorHandler.dispatchInternalServerError(res, err);
    }
  });



  router.get("/testCron", async (req, res, next) => {
    //get all stff
    const todayMonthDay= moment().format("DD/MM");

    const allStaff= await models.Staff.findAll();

    
    for (staff of allStaff){

      const staffBirthDay=moment(staff.birthDay).format("DD/MM");

      if(staffBirthDay==todayMonthDay ){

        try{
          const celebrant= staff;
          const displayName= await cardRepository.resolveStaffDisplayName(staff.id);
          const celebrantFirstname= await cardRepository.resolveStaffFirstName(staff.id);
          const  downloadLink = await cardRepository.resolveBirthdayCard(displayName)
          const cardName=downloadLink.cardName;
          const  htmlMessage = await cardRepository.resolveHtmlMessage(displayName, downloadLink.downloadLink, cardName);
          const attachments=downloadLink.physicalLink;
          const status = await utility.sendBirthDayCardToCelebrant(staff.email,htmlMessage, celebrantFirstname, attachments, cardName);
         
          const updated = await models.Staff.update({status:1,cardDownloadLink:downloadLink.downloadLink, jobTitle:downloadLink.physicalLink}, {where:{id:staff.id}});

        }catch(e){
            console.log(e)
            const updated = await models.Staff.update({status:2}, {where:{id:staff.id}});
            
            continue;
        }

      } else {

        continue;
      }

    }

    tb.responsify(res, 200, "success", null);
    
    
  });

//export Router object to make it publicly accessible
module.exports = router;
