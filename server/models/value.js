'use strict';


module.exports = (sequelize, DataTypes) => {

  const Value = sequelize.define('Value', {
    name:DataTypes.STRING
  }, {});

  Value.associate = function (models) {
    // associations can be defined here
    Value.hasMany(models.Nomination,{
      as :"value",
      onDelete:"CASCADE",
      foreignKey:{
        name:"valueId",
        allowNull: false
      }
    });
  };

  return Value;
};