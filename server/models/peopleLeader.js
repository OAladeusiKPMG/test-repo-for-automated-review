"use strict";

module.exports = (sequelize, DataTypes) => {
  const PeopleLeader = sequelize.define(
    "PeopleLeader",
    {
      name: DataTypes.STRING,
      designation: DataTypes.STRING,
      division: DataTypes.STRING,
      unit: DataTypes.STRING,
      email: DataTypes.STRING
    },
    {}
  );

  PeopleLeader.associate = function (models) {
    // define model associations here
  };

  return PeopleLeader;
};