"use strict";

module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    "User",
    {
      username: DataTypes.STRING,
      password: {
        type: DataTypes.STRING,
        // get: function () {
        //   return "N/A";
        // },
      },
      firstName: DataTypes.STRING,
      lastName: DataTypes.STRING,
      email: DataTypes.STRING,
      division: DataTypes.STRING,
      assignedFunction: DataTypes.STRING,
      unit: DataTypes.STRING,
      jobTitle: DataTypes.STRING,
      profilePicture: DataTypes.STRING,
      isDeleted: DataTypes.INTEGER,
      isApproverOrLeader: DataTypes.INTEGER
    },
    {}
  );

  User.associate = function (models) {
    // associations can be defined here
    User.hasOne(models.UserRole,{
      as :"userRole",
      onDelete:"CASCADE",
      foreignKey:{
        name:"userId",
        allowNull: false
      }
    });
    User.hasMany (models.Nomination,{
      as :"nominee",
      onDelete:"CASCADE",
      foreignKey:{
        name:"nomineeId",
        allowNull: false
      }
    });

    User.hasMany(models.Nomination,{
      as :"sponsor",
      onDelete:"CASCADE",
      foreignKey:{
        name:"sponsorId",
        allowNull: false
      }
    });

    User.hasMany(models.Nomination,{
      as :"approver",
      onDelete:"CASCADE",
      foreignKey:{
        name:"approverId",
        allowNull: true
      }
    });
    
    
    

  };

  return User;
};