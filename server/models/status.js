'use strict';


module.exports = (sequelize, DataTypes) => {

  const Status = sequelize.define('Status', {
    name:DataTypes.STRING
  }, {});

  Status.associate = function (models) {
    // associations can be defined here
    Status.hasMany (models.Nomination,{
      as :"status",
      onDelete:"CASCADE",
      foreignKey:{
        name:"statusId",
        allowNull: false
      }
    });
    
  };

  return Status;
};