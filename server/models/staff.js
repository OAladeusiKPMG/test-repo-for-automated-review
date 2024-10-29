'use strict';


module.exports = (sequelize, DataTypes) => {

  const Staff = sequelize.define('Staff', {
    personnelId:DataTypes.INTEGER,
    username:DataTypes.STRING,
    firstName:DataTypes.STRING,
    lastName:DataTypes.STRING,
    displayName:DataTypes.STRING,
    email:DataTypes.STRING,
    unit:DataTypes.STRING,
    division:DataTypes.STRING,
    jobTitle:DataTypes.STRING,
    level:DataTypes.STRING,
    status:DataTypes.INTEGER,
    birthDay:DataTypes.DATEONLY,
    cardDownloadLink:DataTypes.STRING
  }, {});

  Staff.associate = function (models) {
    // associations can be defined here
    // User.belongsTo(models.UserRole);
  };

  return Staff;
};