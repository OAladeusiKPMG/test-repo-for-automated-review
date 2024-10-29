'use strict';
module.exports = (sequelize, DataTypes) => {

  const Unit = sequelize.define('Unit', {
    name: DataTypes.STRING
  }, {});

  Unit.associate = function(models) {
    // associations can be defined here
    // Function.hasMany(models.Template)
  };

  return Unit;
};