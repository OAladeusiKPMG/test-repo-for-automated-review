const tb = require("../components/utils/toolbox");
const config = require("../config");
const cron = require("node-cron");
const models = require("../server/models/index");
const { Op } = require("sequelize");

//cron utility functions
const utility = require("../utils/utils");

const cardRepository= require("../repository/card.repository")
const moment = require("moment");
const db = require("../server/models/index");



const RunCorn = () => {

  //every 7AM to close afternoon and allday timeblocks
  cron.schedule("0 7 * * *", async () => {
    //get all stff
    const todayMonthDay= moment().format("DD/MM");

    // const allStaff= await models.Staff.findAll();
    //send emails to testers only
  const allStaff= await models.Staff.findAll({where:{unit:"tester"}});

    
    for (staff of allStaff){

      const staffBirthDay=moment(staff.birthDay).format("DD/MM");

      if(staffBirthDay==todayMonthDay ){

        try{
          const celebrant= staff;
          const displayName=  await cardRepository.resolveStaffDisplayName(staff.id);
          const celebrantFirstname= await cardRepository.resolveStaffFirstName(staff.id);
          const downloadLink = await cardRepository.resolveBirthdayCard(displayName)
          const cardName=downloadLink.cardName;
          const htmlMessage = await cardRepository.resolveHtmlMessage(displayName, downloadLink.downloadLink,cardName);
          const attachments=downloadLink.physicalLink;
          const status = await utility.sendBirthDayCardToCelebrant(staff.email,htmlMessage,celebrantFirstname,attachments,cardName);
          const updated = await models.Staff.update({status:1,cardDownloadLink:downloadLink.downloadLink, jobTitle:downloadLink.physicalLink}, {where:{id:staff.id}});

        }catch(e){
            console.log(e)
            const updated = await models.Staff.update({status:2,level:e}, {where:{id:staff.id}});
            
            continue;
        }

      } else {

        continue;
      }

    }
    
    
  });

  console.log("Cron Jobs Running");
};

module.exports = {
  RunCorn,
};
