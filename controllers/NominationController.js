///References
const express = require("express");
const tb = require("../components/utils/toolbox");
const errorHandler = require("../components/errorHandler");
const jwt = require("jsonwebtoken");
const config = require("../config");
//Models import
const models = require("../server/models/index");
//Instantiations
//Instantiate express router
const router = express.Router();
//other dependencies
//model properties validation
const { body, validationResult } = require("express-validator");
const modelvalidators = require("../middlewares/modelValidators");
//model properties validation
//model utility functions

const nominationRepository= require("../repository/nomination.repository")
//append text to image
const Jimp = require("jimp");

const { Op } = require('sequelize');
const path = require('path');

const utility = require("../utils/utils")

const moment = require("moment");




/**API endpoint list
 * get all reservations for admin only
 * */
router.post("/createNomination", tb.jwtAuthorize, async (req, res, next) => {
  try {
      const currentUser = tb.getJwtCurentUser(req);
      const sponsorId=currentUser.user.id;

      let data = req.body;

      data.sponsorId= sponsorId;
      let nom;

      if(data.sponsorId== data.nomineeId){
        
      tb.responsify(res, 500, "You cannot nominate yourself for an award", "You cannot nominate yourself for an award.");

      }else{


      //cheers
      if(data.categoryId==2){
        /*employee below senior associate level cannot niminate for cheers*/
       // console.log(JSON.stringify(currentUser))
        const  jobTitle= currentUser.user.jobTitle.toLowerCase();

        if(jobTitle.includes('senior')|| jobTitle.includes('manager') || jobTitle.includes('director') || jobTitle.includes('partner')){
         
        //convert this to a function and place it in nomintaion repository
          //check that sponsor has not nomintaion a staff for cheers in three months
          sponsorLastNominationForCheers= await models.Nomination.findOne({
            where:{categoryId:2, sponsorId:sponsorId},
            order: [['id', 'DESC']]
          })
          if (sponsorLastNominationForCheers) {
            const createdAt = moment(sponsorLastNominationForCheers.createdAt);
            const today = moment();
            const differenceInMonths = today.diff(createdAt, 'months');
      
            if (differenceInMonths <= 3) {
              tb.responsify(res, 500, "Nomination declined. You can only submit one nomination per quarter");

            } else {
              nom= await nominationRepository.createNomination(data, sponsorId);
              tb.responsify(res, 200, "success", nom);
              
            }
          } else {
            nom= await nominationRepository.createNomination(data, sponsorId);
            tb.responsify(res, 200, "success", nom);

          }
          //check that sponsor has not nomintaion a staff for cheers in three months

        }else{
          tb.responsify(res, 500, "Employee below senior associate level cannot niminate for cheers", "Employee below senior associate level cannot niminate for cheers");
        }


        //applause
      }else if(data.categoryId==3){
        //employee below manager level cannot niminate for applause
        const  jobTitle= currentUser.user.jobTitle.toLowerCase();

        if(jobTitle.includes('manager') || jobTitle.includes('director') || jobTitle.includes('partner')){
          //console.log(1);


          //convert this to a function and place it in nomintaion repository
          //check that sponsor has not nomintaion a staff for cheers in three months
          sponsorLastNominationForApplause= await models.Nomination.findOne({
            where:{categoryId:3, sponsorId:sponsorId},
            order: [['id', 'DESC']]
          })
          if (sponsorLastNominationForApplause) {
            const createdAt = moment(sponsorLastNominationForApplause.createdAt);
            const today = moment();
            const differenceInMonths = today.diff(createdAt, 'months');
      
            if (differenceInMonths <= 6) {
              tb.responsify(res, 500, "Nomination declined. You can only submit one nomination for applause every six months");
              


            } else {
              nom= await nominationRepository.createNomination(data, sponsorId);
              tb.responsify(res, 200, "success", nom);

            }
          } else {
            nom= await nominationRepository.createNomination(data, sponsorId);
            tb.responsify(res, 200, "success", nom);

          }
          //check that sponsor has not nomintaion a staff for cheers in three months


        }else{
          tb.responsify(res, 500, "Employee below manager level cannot niminate for applause", "employee below manager level cannot niminate for applause");

        }

      }else{
        //noinate for Thanks
       nom= await nominationRepository.createNomination(data, sponsorId);
       //send card without approval if user is nominated for "Thanks"
        console.log(data.nomineeId)
        const sent = await nominationRepository.sendThanksCard(data.nomineeId, data)
        tb.responsify(res, 200, "success", nom);


      

      }
    
    }

  
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});


// Get all nimination - paginated
router.get("/getAllNominationsPaginated", async (req, res, next) => {
  try {
      const currentUser= tb.getJwtCurentUser(req);
      let perPage = Number((typeof req.query.perPage == "undefined") ? 10 : req.query.perPage);
      const page = Number(req.query.page);

      let whereCondition={};
      if(req.query.searchKey){
        whereCondition = {where:{justification: {
          [Op.like]: `%${req.query.searchKey}%`
        } }}
      }

      else if(req.query.statusFilterId){
        whereCondition = {where:{statusId:req.query.statusFilterId}}
      }

     else if(req.query.categoryFilterId){
        whereCondition = {where:{categoryId:req.query.categoryFilterId}}
      }


      // const staffList = await models.Staff.findAll({ where: { status: 1 } });
      if(currentUser.user.isApproverOrLeader==1){
        //fetch nominations assigned to the approver
          whereCondition={where:{approverId:currentUser.user.id}}
      }


      let nomList = await models.Nomination.findAll({
        ...whereCondition,
        include:[
          { model:models.User, as:"nominee"},
          { model:models.User, as:"sponsor"},
          { model:models.User, as:"approver"},
          { model:models.Status, as:"status"},
          { model:models.Category, as:"category"},
          { model:models.Value, as:"value"},
      ],
      offset:(page-1)*perPage,
      limit:perPage,
      // order:[["id","DESC"]]
      });
      nomList= nomList.reverse()
      //console.log(users)
      let total = (await models.Nomination.findAll({...whereCondition})).length;
      // console.log(total);
      const paginated = await tb.paginateArray(nomList, total, page, perPage)


      tb.responsify(res, 200, "success", paginated)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});


// router.get("/getAllNominationsPaginated", async (req, res, next) => {
//   try {
//       let perPage = Number((typeof req.query.perPage == "undefined") ? 10 : req.query.perPage);
//       const page = Number(req.query.page);

//       let whereCondition={};
//       if(req.query.searchKey){
//         whereCondition = {where:{justification: {
//           [Op.like]: `%${req.query.searchKey}%`
//         } }}
//       }

//       else if(req.query.statusFilterId){
//         whereCondition = {where:{statusId:req.query.statusFilterId}}
//       }

//      else if(req.query.categoryFilterId){
//         whereCondition = {where:{categoryId:req.query.categoryFilterId}}
//       }

//       if(currentUser.isApproverOrLeader==1){
//         //fetch nominations assigned to the approver
//           whereCondition={where:{approverId:currentUser.id}}
//       }

//       // const staffList = await models.Staff.findAll({ where: { status: 1 } });
//       let nomList = await models.Nomination.findAll({
//         ...whereCondition,
//         include:[
//           { model:models.User, as:"nominee"},
//           { model:models.User, as:"sponsor"},
//           { model:models.User, as:"approver"},
//           { model:models.Status, as:"status"},
//           { model:models.Category, as:"category"},
//           { model:models.Value, as:"value"},
//       ],
//       offset:(page-1)*perPage,
//       limit:perPage,
//       order:[["id","DESC"]]
//       });
//       // nomList= nomList.reverse()
//       //console.log(users)
//       const paginated = nomList

//       tb.responsify(res, 200, "success", nomList)

//   } catch (err) {
//       errorHandler.dispatchInternalServerError(res, err)
//   }
// });

router.get("/getCurrentUserNominations", async (req, res, next) => {
  try {
      const currentUser = tb.getJwtCurentUser(req);
      let sponsorId= currentUser.user.id;
      let perPage = Number((typeof req.query.perPage == "undefined") ? 10 : req.query.perPage);
      const page = Number(req.query.page);
      // const staffList = await models.Staff.findAll({ where: { status: 1 } });

      let whereCondition={};
      if(req.query.searchKey){
        whereCondition = {where:{justification: {
          [Op.like]: `%${req.query.searchKey}%`
        } }}
      }

      else if(req.query.statusFilterId){
        whereCondition = {where:{statusId:req.query.statusFilterId}}
      }

     else if(req.query.categoryFilterId){
        whereCondition = {where:{categoryId:req.query.categoryFilterId}}
      }

      let nomList = await models.Nomination.findAll({
        where: { sponsorId:sponsorId, ...whereCondition.where },
        include:[
          { model:models.User, as:"nominee"},
          { model:models.User, as:"sponsor"},
          { model:models.User, as:"approver"},
          { model:models.Status, as:"status"},
          { model:models.Category, as:"category"},
          { model:models.Value, as:"value"},
      ],
      offset:(page-1)*perPage,
      limit:perPage,
      // order:[["id","DESC"]]
      });
      nomList= nomList.reverse()
      // //console.log(users)
      let total = (await models.Nomination.findAll({...whereCondition})).length;
      const paginated = await tb.paginateArray(nomList, total, page, perPage);

      tb.responsify(res, 200, "success", paginated)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});


router.get("/getNominationById", async (req, res, next) => {
  try {

      let niminationId= req.query.nominationId
    
      let nom = await models.Nomination.findOne({
        where: {id:niminationId},
        include:[
          { model:models.User, as:"nominee"},
          { model:models.User, as:"sponsor"},
          { model:models.User, as:"approver"},
          { model:models.Status, as:"status"},
          { model:models.Category, as:"category"},
          { model:models.Value, as:"value"},
      ]
      });

      tb.responsify(res, 200, "success", nom)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});


router.get("/approveNomination", tb.jwtAuthorize, async (req, res, next) => {
  try {
    
      let nominationId= req.query.nominationId
      let reason= req.query.reason?req.query.reason:"";
    
     let nomination = await models.Nomination.findOne({where:{id:nominationId}});

     let result = await models.Nomination.update({statusId:config.statusIds.approved, reason:decodeURIComponent(reason), approvedAt:moment()}, {where:{id:nominationId}})
 
      //send card without approval if user is nominated for "Thanks"

    const sent = await nominationRepository.sendCheersOrApplauseCard(nomination.nomineeId, nomination)


    tb.responsify(res, 200, "success", result)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});


router.get("/rejectNomination", tb.jwtAuthorize, async (req, res, next) => {
  try {
    
      let nominationId= req.query.nominationId
      let reason= req.query.reason?req.query.reason:"";

    
     let result = await models.Nomination.update({statusId:config.statusIds.rejected, reason: decodeURIComponent(reason)}, {where:{id:nominationId}})

    tb.responsify(res, 200, "success", result)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});

router.get("/downloadNominations", async (req, res, next) => {
  try {
      const currentUser = tb.getJwtCurentUser(req);
      let sponsorId= currentUser.user.id;

      let perPage = Number((typeof req.query.perPage == "undefined") ? 10 : req.query.perPage);
      const page = Number(req.query.page);
      // const staffList = await models.Staff.findAll({ where: { status: 1 } });

      let whereCondition={};
      if(req.query.searchKey){
        whereCondition = {where:{justification: {
          [Op.like]: `%${req.query.searchKey}%`
        } }}
      }

      else if(req.query.statusFilterId){
        whereCondition = {where:{statusId:req.query.statusFilterId}}
      }

     else if(req.query.categoryFilterId){
        whereCondition = {where:{categoryId:req.query.categoryFilterId}}
      }

      let nomList = await models.Nomination.findAll({
        where: { sponsorId:sponsorId, ...whereCondition.where }
        ,
        include:[
          { model:models.User, as:"nominee"},
          { model:models.User, as:"sponsor"},
          { model:models.User, as:"approver"},
          { model:models.Status, as:"status"},
          { model:models.Category, as:"category"},
          { model:models.Value, as:"value"},
      ],
      offset:(page-1)*perPage,
      limit:perPage,
      // order:[["id","DESC"]]
      });
      nomList= nomList.map(x => x.get({ plain: true }))
      nomList= nomList.reverse()

      
      //console.log(users)
      const paginated = await tb.paginateArray(nomList, page, perPage)
 

      const formatedList=[];
      paginated.data.map((nom, index)=>{
        formatedList.push({
          ID:index,
          Nominee:`${nom.nominee?.lastName} ${nom.nominee?.firstName}`,
          Sponsor:`${nom.sponsor?.lastName} ${nom.sponsor?.firstName}`,
          Status:`${nom.status?.name}`,
          Category:`${nom.category?.name}`,
          Justification:nom.justification,
          Value:`${nom.value?.name}`,
          ApprovalOrRejectionReason: `${nom.reason}`
        })
      })

      let randomText=await tb.generateRandomNumberString(10);
      let downloadFileName="data.csv"+randomText+".csv";
      let downloadPath=path.join(path.resolve(config.uploadPaths.downloadRelativePath),downloadFileName)
       let savedPath = await tb.convertJsonToCsv(downloadPath, formatedList);
       const downloadLink=config.BaseUrl+"/downloads/"+downloadFileName;
      tb.responsify(res, 200, "success", downloadLink)

  } catch (err) {
      errorHandler.dispatchInternalServerError(res, err)
  }
});

//API endpoint list
//get all reservations for admin only
// router.post("/createNomination", tb.jwtAuthorize, async (req, res, next) => {
//   try {
//     const currentUser = tb.getJwtCurentUser(req);
//     if (currentUser.user.role == config.roleNames.admin) {


//       const {staffId} = req.body;

//       const staff= await nominationRepository.resolveStaffById(staffId);

//       const displayName= await nominationRepository.resolveStaffDisplayName(staffId);

//       const  downloadLink = await nominationRepository.resolveBirthdayCard(displayName)

//       //store in db

//       const updated = await models.Staff.update({cardDownloadLink:downloadLink.downloadLink, jobTitle:downloadLink.physicalLink, level:downloadLink.cardName}, {where:{id:staffId}});

//       tb.responsify(res, 200, "success", downloadLink);

//     } else {
//       tb.responsify(res, 201, "Authorized", "access denied for user");
//     }
//   } catch (err) {
//     errorHandler.dispatchInternalServerError(res, err);
//   }
// });



router.post("/sendCard", tb.jwtAuthorize, async (req, res, next) => {
  try {
    const currentUser = tb.getJwtCurentUser(req);
    if (currentUser.user.role == config.roleNames.admin) {


      const {staffId} = req.body;

      try{
      const staff= await nominationRepository.resolveStaffById(staffId);

      const displayName= await nominationRepository.resolveStaffDisplayName(staffId);

      const celebrantFirstname= await nominationRepository.resolveStaffFirstName(staffId);

      const cardName=staff.level;

      const  htmlMessage = await nominationRepository.resolveHtmlMessage(displayName, staff.cardDownloadLink, cardName)

      const attachments=staff.jobTitle;
      //console.log("ddd"+attachments)

      const status = await utility.sendBirthDayCardToCelebrant(staff.email, htmlMessage, celebrantFirstname, attachments, cardName );

      const updated = await models.Staff.update({status:1}, {where:{id:staffId}});

      tb.responsify(res, 200, "success", status);


      }catch(e){

      const updated = await models.Staff.update({status:2}, {where:{id:staffId}});

      tb.responsify(res, 500, "Failed. Please send manually", "failed. Please send manually");


      }


    } else {
      tb.responsify(res, 201, "Authorized", "access denied for user");
    }
  } catch (err) {
    
    errorHandler.dispatchInternalServerError(res, err);
  }
});





//export Router object to make it publicly accessible
module.exports = router;