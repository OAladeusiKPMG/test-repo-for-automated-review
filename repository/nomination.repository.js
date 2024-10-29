//References
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
const cardRepository= require("../repository/card.repository")
const utility= require("../utils/utils")

//append text to image
const Jimp = require("jimp");

const { Op } = require('sequelize');
const path = require('path');




const createNomination= async (data,sponsorId)=>{

  try{

  var newRecord;
  var toCreate= {
    nomineeId:data.nomineeId,
    sponsorId: sponsorId,
    categoryId:data.categoryId,
    statusId:(data.categoryId==1)?2:1,
    valueId:data.valueId,
    justification:data.justification,
    description:data.justification,
    isDeleted:0,
    reason:"",
  }
 
  //create nomination
  result = await models.Nomination.create(toCreate);


  if(data.categoryId != 1){

    const staff= await cardRepository.resolveUserById(data.nomineeId);
    const nomineeJobTitle= staff.jobTitle.toLowerCase();
    const nomineeUnit= staff.unit.toLowerCase();
    const nomineeDivision= staff.division.toLowerCase();
    const nominneFullNames= `${staff.firstName} ${staff.lastName}`;
    
    let approvingLeader;
    

    /*Send approval email to People Leader in the Nominee’s Unit or Nominee’s Division People Partner if Nominee is a Manager and above.*/
 

    if( (nomineeJobTitle.includes('manager') && !nomineeJobTitle.includes("assist")) || nomineeJobTitle.includes('director') || nomineeJobTitle.includes('partner')){
     
      approvingLeader=await models.PeopleLeader.findOne({
        where:{
          division:{
            [Op.like]:`%${nomineeDivision}%`
          },
          unit:{
            [Op.like]:`%${nomineeDivision}%`
          }
        }
        });

    }else{

      approvingLeader=await models.PeopleLeader.findOne({
        where:{
          division:{
            [Op.like]:`%${nomineeDivision}%`
          },
          unit:{
            [Op.like]:`%${nomineeUnit}%`
          }
        }
        });

        if(!approvingLeader){
          approvingLeader=await models.PeopleLeader.findOne({
            where:{
              division:{
                [Op.like]:`%${nomineeDivision}%`
              },
              unit:{
                [Op.like]:`%${nomineeDivision}%`
              }
            }
            });
        }

    }


    //console.log(JSON.stringify(approvingLeader))

    let approvingLeadersEmails= approvingLeader.email;

    let approverProfile= await cardRepository.resolveUserByEmail(approvingLeader.email.trim());

    //create the the nomination
    toCreate["approverId"]= approverProfile.id;
     newRecord = await models.Nomination.create(toCreate);
    
    console.log("New Record: "+newRecord.id)



    toCreate[`approverId`]= approverProfile.id;
    //send email notification
    // const message= `<p>${nominneFullNames} has been nominated for ${data.categoryId==2?"Cheers.":"Applause."} Please review and approve the nomination here: http://nglosapp07/encore</p>`
    
    approvingLeader["firstName"]= (approvingLeader.name?.split(`,`)[1]).trim();

    const message =`<!DOCTYPE html>
    <html>
    <head>
      <title>${data.categoryId==2?"Cheers":"Applause"} Award Nomination</title>
    </head>
    <body>
      <p>Dear ${approvingLeader.firstName},</p>
      <p>This is to inform you that <strong>${nominneFullNames}</strong> has been nominated for ${data.categoryId==2?"Cheers":"Applause"} Award.</p>
      <p>Please click <a href="http://nglosapp07/encore/#/login?nomination_id=${newRecord.id}">HERE</a> to review and approve/reject the nomination based on the justification given by the sponsor.</p>
      <p>If approved, the employee would be gifted <strong><em>${data.categoryId==2?"10,000":"20,000"} naira</em></strong> gift voucher and an electronic certificate.</p>
      <p><strong>Best regards,</strong></p>
      <p><strong><em>Employee Engagement and Culture Team.</em></strong></p>
    </body>
    </html>
    `;

    await utility.notifyLeader(approvingLeadersEmails,`${data.categoryId==2?"Cheers":"Applause"} Awards Nomination`, message,nominneFullNames);

  }



  return newRecord;

}catch(e){
  throw e
}

}


const sendThanksCard = async (nomineeId, data)=>{

  const nominee= await resolveUserById(nomineeId);

      const staff= await cardRepository.resolveUserById(nomineeId);


      //const displayName= await cardRepository.resolveStaffDisplayName(nomineeId);

      const  downloadLinks = await cardRepository.resolveCard(staff, data)

      const  htmlMessage = await cardRepository.resolveHtmlMessage(downloadLinks.cardName, data)

      const attachments=downloadLinks.physicalLink;

      //commnt this line out on production
      // staff.email="Oluwatoyin.Aponinuola@ng.kpmg.com;Deborah.Adediran@ng.kpmg.com;olugbenga.aladeusi@ng.kpmg.com;Olaniyi.Adekanmbi@ng.kpmg.com;Adebimpe.Ariyo@ng.kpmg.com;Ifeoma.Emmanuel-Edem@ng.kpmg.com";
      const status = await utility.sendCardToNominee(staff.email, "Thanks E-Card", htmlMessage, staff.firstName, attachments, downloadLinks.cardName, data.categoryId );

}



const sendCheersOrApplauseCard = async (nomineeId, data)=>{

  const nominee= await resolveUserById(nomineeId);

      const staff= await cardRepository.resolveUserById(nomineeId);

      // const displayName= await cardRepository.resolveStaffDisplayName(nomineeId);

      const  downloadLink = await cardRepository.resolveCard(staff, data)


      const cardName=staff.personnelId;

      const  htmlMessage = await cardRepository.resolveHtmlMessage(downloadLink.cardName, data)

      const attachments=downloadLink.physicalLink;
      const emailTitle=data.categoryId==2?"Cheers Award Certificate":"Applause Award Certificate";
      //commnt this line out on production
      // staff.email="Oluwatoyin.Aponinuola@ng.kpmg.com;Deborah.Adediran@ng.kpmg.com;olugbenga.aladeusi@ng.kpmg.com;Olaniyi.Adekanmbi@ng.kpmg.com;Adebimpe.Ariyo@ng.kpmg.com;Ifeoma.Emmanuel-Edem@ng.kpmg.com";
      const status = await utility.sendCardToNominee(staff.email, emailTitle, htmlMessage, staff.firstName, attachments, cardName, data.categoryId );

}


const resolveStaffById= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  console.log(staff)
  return staff;
}

const resolveUserById= async (staffId)=>{
  const staff = await models.User.findOne({where:{id:staffId}});
  console.log(staff)
  return staff;
}

const resolveStaffDisplayName= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  return `${staff.lastName}, ${staff.firstName}`;
}

const resolveStaffFirstName= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  return `${staff.firstName}`;
}


const resolveBirthdayCard= async (displayName)=>{

  let randomIndex=Math.floor(Math.random()*config.birthDayMessages.length);
  if(randomIndex==0){randomIndex++}
  if(randomIndex>config.birthDayMessages.length){randomIndex=config.birthDayMessages.length}
  
  const getBirthDayMessageRandomly= config.birthDayMessages[randomIndex];

  try{

  const fileExtension="png";


  // const cardTemplateName= `${getBirthDayMessageRandomly.id}.${fileExtension}`
  const cardTemplateName= `${getBirthDayMessageRandomly.id}.${fileExtension}`

  let cardNewName=await tb.generateRandomNumberString(30);
  cardNewName= `${cardNewName}.${fileExtension}`

  let cardTemplatePath=path.join(path.resolve(config.uploadPaths.birthDayCardTemplatePath),cardTemplateName)
  let cardPath=path.join(path.resolve(config.uploadPaths.birthDayCardRelativePath),cardNewName)


  // Reading image
  const image = await Jimp.read(cardTemplatePath);

switch (getBirthDayMessageRandomly.id){
  case 1:
    // Defining the text font
  let  font1 = await Jimp.loadFont(Jimp.FONT_SANS_32_BLACK);
  //insert content
  image.print(font1, 770, 300, {
    text: `${config.getBirthDayMessageRandomly.value1}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },900 );
//insert message 2
  image.print(font1, 770, 450, {
    text: `${config.getBirthDayMessageRandomly.value2}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },900 );
  //insert name
  image.print(font1, 890, 860, {
    text: `${displayName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },900 );
    break;

  case 2:
     // Defining the text font
  const font2_ = await Jimp.loadFont(Jimp.FONT_SANS_32_BLACK);
  const font2 = await Jimp.loadFont(Jimp.FONT_SANS_16_BLACK);
  //insert content
  //insert name
  image.print(font2_, 260, 565, {
    text: `${displayName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },480);
  //insert message 1
  image.print(font2, 50, 650, {
    text: `${getBirthDayMessageRandomly.value1}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },750 );
//insert message 2
  image.print(font2, 50, 710, {
    text: `${getBirthDayMessageRandomly.value2}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },750 );
    break;
  case 3:
  // Defining the text font
  const font3 = await Jimp.loadFont(Jimp.FONT_SANS_14_BLACK);
  //insert content
  //insert name
  image.print(font3, 180, 400, {
    text: `${displayName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },480);
  //insert message 1
  image.print(font3, 180, 440, {
    text: `${getBirthDayMessageRandomly.value1}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },480 );
//insert message 2
  image.print(font3, 180, 510, {
    text: `${getBirthDayMessageRandomly.value2}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },480 );
    break;
  case 4:
      // Defining the text font
  const font4_ = await Jimp.loadFont(Jimp.FONT_SANS_64_BLACK);
  const font4 = await Jimp.loadFont(Jimp.FONT_SANS_32_BLACK);
  //insert content
  //insert name
  image.print(font4_, 565, 150, {
    text: `${displayName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1000);
  //insert message 1
  image.print(font4, 240, 700, {
    text: `${getBirthDayMessageRandomly.value1}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_CENTER,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1500 );
//insert message 2
  image.print(font4, 240, 800, {
    text: `${getBirthDayMessageRandomly.value2}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_CENTER,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1500);
    break;
  default:
  // Defining the text font
  const font6_ = await Jimp.loadFont(Jimp.FONT_SANS_64_BLACK);
  const font6 = await Jimp.loadFont(Jimp.FONT_SANS_32_BLACK);
  //insert content
  //insert name
  image.print(font6_, 565, 150, {
    text: `${displayName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1000);
  //insert message 1
  image.print(font6, 240, 700, {
    text: `${getBirthDayMessageRandomly.value1}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_CENTER,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1500 );
//insert message 2
  image.print(font6, 240, 800, {
    text: `${getBirthDayMessageRandomly.value2}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_CENTER,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1500);
    break;
}

  // Writing image after processing
  await image.writeAsync(cardPath);
 
  let downloadLink ={downloadLink:`${config.BaseUrl}${config.uploadPaths.birthDayCardURL}/${cardNewName}`,physicalLink:cardPath, cardName:cardNewName};
  return downloadLink ;
}catch(e){
  const f=randomIndex;
  const j=e;
}
}


const resolveHtmlMessage=async(displayName, downloadLink, cardName)=>{
  const html=`
    <div>
    <img src="${cardName}" />
    </div>
  `;
  return html;
}



module.exports = {
  createNomination,
  sendThanksCard,
  sendCheersOrApplauseCard,
  resolveBirthdayCard,
  resolveHtmlMessage,
  resolveStaffDisplayName,
  resolveStaffById,
  resolveStaffFirstName
};
