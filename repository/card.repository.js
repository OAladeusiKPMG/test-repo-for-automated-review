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
//append text to image
const Jimp = require("jimp");

const { Op } = require('sequelize');
const path = require('path');


const resolveStaffById= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  console.log(staff);
  return staff;
}

const resolveUserById= async (staffId)=>{
  const staff = await models.User.findOne({where:{id:staffId}});
  console.log(staff);
  return staff;
}

const resolveUserByEmail= async (email)=>{
  const staff = await models.User.findOne({where:{email:email}});
  console.log(staff);
  return staff;
}

const resolveStaffDisplayName= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  // return `${staff.lastName}, ${staff.firstName}`;
  return `${staff.firstName}`;
}

const resolveStaffFirstName= async (staffId)=>{
  const staff = await models.Staff.findOne({where:{id:staffId}});
  return `${staff.firstName}`;
}


const resolveKPMGValue= async (valueId)=>{
  const value = await models.Value.findOne({where:{id:valueId}});
  return `${value.name}`;
}


const resolveCard= async (staff, data)=>{

  try{

  const fileExtension="JPG";

  let cardNewName=await tb.generateRandomNumberString(30);
  cardNewName= `${staff.username}_${cardNewName}.${fileExtension}`

  let cardPath=path.join(path.resolve(config.uploadPaths.cardRelativePath),cardNewName)

 let image ;
 
 const _displayName=`${staff.firstName} ${staff.lastName}`;

switch (data.categoryId){

  case 1:
    //The card is for Thanks
  image=await Jimp.read(path.join(path.resolve(config.uploadPaths.cardTemplatePath),`thanks.PNG`))

  
    break;

  case 2:
     // The card is for applause
    image=await Jimp.read(path.join(path.resolve(config.uploadPaths.cardTemplatePath),`cheers.${fileExtension}`))

     // Defining the text font
  const font2_ = await Jimp.loadFont( _displayName.length<16?Jimp.FONT_SANS_64_BLACK: Jimp.FONT_SANS_32_BLACK);
  // const font2 = await Jimp.loadFont(Jimp.FONT_SANS_16_BLACK);
  //insert content
  //insert name
  image.print(font2_,  97, 480, {
    text: `${staff.firstName} ${staff.lastName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1000);

    break;

  case 3:
    image=await Jimp.read(path.join(path.resolve(config.uploadPaths.cardTemplatePath),`applause.${fileExtension}`))
  // Defining the text font
  const font3 = await Jimp.loadFont(_displayName.length<16?Jimp.FONT_SANS_64_BLACK: Jimp.FONT_SANS_32_BLACK);
  //insert content
  //insert name
  image.print(font3,  97, 480, {
    text: `${staff.firstName} ${staff.lastName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1000);

   break;
  default:
  // Defining the text font
  const font6_ = await Jimp.loadFont(_displayName.length<16?Jimp.FONT_SANS_64_BLACK: Jimp.FONT_SANS_32_BLACK);
  // const font6 = await Jimp.loadFont(Jimp.FONT_SANS_64_BLACK);
  //insert content
  //insert name
  image.print(font6_, 565, 150, {
    text: `${staff.firstName} ${staff.lastName}`,
    alignmentX: Jimp.HORIZONTAL_ALIGN_LEFT,
    alignmentY: Jimp.VERTICAL_ALIGN_TOP
  },1000);
    break;
}

  // Writing image after processing
  await image.writeAsync(cardPath);

  //console.log(`${config.BaseUrl}${config.uploadPaths.cardURL}/${cardNewName}`)
 
  let downloadLinks ={downloadLink:`${config.BaseUrl}${config.uploadPaths.cardURL}/${cardNewName}`,physicalLink:cardPath, cardName:cardNewName};
  return downloadLinks ;
}catch(e){

  const j=e;
}
}


const resolveHtmlMessage=async(cardName, data)=>{
  // cardName="111"+JSON.stringify(cardName);

  const sponsor= await resolveUserById(data.sponsorId);
  const sporsorFullNames= `${sponsor.lastName}, ${sponsor.firstName}`;

  const staff= await resolveUserById(data.nomineeId);

  let html=`
    <div>
    <img src="${cardName}" />
    <br>
    <br>
    <div><b>KPMG Value</b></div>
    <div>${await resolveKPMGValue(data.valueId)}</div>
    <br>
    <div><b>Thanks Message</b></div>
    <div>${data.justification}</div>
    <br>
    <div><b>Message From</b></div>
    <div>${sporsorFullNames}</div>
    </div>
  `;

  if(data.categoryId>1){
    html=`<!DOCTYPE html>
    <html>
    <head>
      <title>${data.categoryId==2?'Cheers':'Applause'} Awards Nomination</title>
    </head>
    <body>
      <p>Dear ${staff.firstName},</p>
      <p>Congratulations on being nominated for the Encore Awards!</p>
      <p>You will receive a voucher worth <strong>${data.categoryId==2?'10,000':'20,000'} naira</strong> and a <em>${data.categoryId==2?'Cheers':'Applause'} E-Award Certificate</em>.</p>
      <p>Please note that a mail will be sent to you from the Employee Engagement & Culture team to collect your voucher.</p>
      <div>
        <img src="${cardName}" />
        <br>
        <br>
        <div><b>KPMG Value</b></div>
        <div>${await resolveKPMGValue(data.valueId)}</div>
        <br>
        <div><b>Justification</b></div>
        <div>${data.justification}</div>
        <br>
        <div><b>Sponsor Name</b></div>
        <div>${sporsorFullNames}</div>
      </div>
      <p><strong>Best regards,</strong></p>
      <p><em>Employee Engagement and Culture Team.</em></p>
    </body>
    </html>
    `
  }
  console.log(html)
  return html;
}



module.exports = {
  resolveUserByEmail,
  resolveCard,
  resolveHtmlMessage,
  resolveStaffDisplayName,
  resolveStaffById,
  resolveStaffFirstName,
  resolveUserById,
  resolveKPMGValue
};
