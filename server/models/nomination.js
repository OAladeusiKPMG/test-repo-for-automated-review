"use strict";
const moment = require("moment");

module.exports = (sequelize, DataTypes) => {
  const Nomination = sequelize.define(
    "Nomination",
    {
      nomineeId: DataTypes.INTEGER,
      sponsorId: DataTypes.INTEGER,
      approverId: DataTypes.INTEGER,
      categoryId: DataTypes.INTEGER,
      statusId: DataTypes.INTEGER,
      valueId: DataTypes.INTEGER,
      justification:DataTypes.STRING,
      description:DataTypes.STRING,
      reason:DataTypes.STRING,
      approvedAt: {
        type: DataTypes.DATE,
        get: function () {
          return moment.utc(this.getDataValue("date")).format("DD-MMM-YYYY");
        },
      },
      isDeleted: DataTypes.INTEGER
    },
    {}
  );

  Nomination.associate = function (models) {
    // associations can be defined here
    Nomination.belongsTo(models.User, {
      as:"nominee",
      foreignKey:{
        name:"nomineeId",
        allowNull: false
      }
    });

    Nomination.belongsTo(models.User, {
      as:"sponsor",
      foreignKey:{
        name:"sponsorId",
        allowNull: false
      }
    });

    Nomination.belongsTo(models.User, {
      as:"approver",
      foreignKey:{
        name:"approverId",
        allowNull: true
      }
    });

    Nomination.belongsTo(models.Category, {
      as : "category",
      foreignKey:{
        name:"categoryId",
        allowNull: false
      }

    });

    Nomination.belongsTo(models.Status, {
      as : "status",
      foreignKey:{
        name:"statusId",
        allowNull: false
      }
    });

    Nomination.belongsTo(models.Value, {
      as : "value",
      foreignKey:{
        name:"valueId",
        allowNull: false
      }
    });
  };

  return Nomination;
};
