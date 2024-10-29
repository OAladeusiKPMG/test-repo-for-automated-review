'use strict';
module.exports = (sequelize, DataTypes) => {

  const UserRole = sequelize.define('UserRole', {
    userId: DataTypes.INTEGER,
    roleId: DataTypes.INTEGER
  }, {});

  UserRole.associate = function(models) {
    // associations can be defined here
    UserRole.belongsTo(models.Role,{
      as :"role",
      onDelete:"CASCADE",
      foreignKey:{
        name:"roleId",
        allowNull: false
      }
    });
    UserRole.belongsTo(models.User,
      {
        as :"user",
        onDelete:"CASCADE",
        foreignKey:{
          name:"userId",
          allowNull: false
        }
      });
  };
  return UserRole;
};