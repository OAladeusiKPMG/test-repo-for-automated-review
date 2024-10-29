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



const sendCardToNominee=async(celebrantEmail,title, htmlMessage, celebrantFirstname,attachments, cardName, categoryId)=>{
   //store in db
   const paramObject={
    to:celebrantEmail,
    cc:(categoryId==1)?"":config.cc,
    bcc:config.bcc,
    subject:`${title}`,
    textBody:"",
    htmlBody:htmlMessage,
    from:config.from,
    attachments:attachments
  }
  //for live sql-based emailing
  const dbMailConnectionInfo={
    dbmailProfileName:config.dbMailProfileName
  }

  //for test smtp-based emailing
  const smtpCredentials=(config.sendLiveMail)?config.smtpConnectionInfo.live:config.smtpConnectionInfo.test;


  let status;
  if(config.sendLiveMail==true){
    //send using sql emailing
   status= await tb.sendSQLSMTPMail(paramObject, dbMailConnectionInfo, config.sendLiveMail)
  }else{
    //sending using mailtrap smtp
    status = await tb.sendSMTPMail(paramObject,smtpCredentials,config.sendLiveMail)
  }
  return status;

}


const notifyLeader=async(leaderEmail,title, htmlMessage, celebrantFullNames)=>{
  //store in db
  const paramObject={
   to:leaderEmail,
   cc:config.cc,
   bcc:config.bcc,
   subject:`${title}`,
   textBody:"",
   htmlBody:htmlMessage,
   from:config.from
  //  ,attachments:attachments
 }
 //for live sql-based emailing
 const dbMailConnectionInfo={
   dbmailProfileName:config.dbMailProfileName
 }

 //for test smtp-based emailing
 const smtpCredentials=(config.sendLiveMail)?config.smtpConnectionInfo.live:config.smtpConnectionInfo.test;


 let status;
 if(config.sendLiveMail==true){
   //send using sql emailing
  status= await tb.sendSQLSMTPMail(paramObject, dbMailConnectionInfo, config.sendLiveMail)
 }else{
   //sending using mailtrap smtp
   status = await tb.sendSMTPMail(paramObject,smtpCredentials,config.sendLiveMail)
 }
 return status;

}

module.exports = {
  sendCardToNominee,
  notifyLeader
};
