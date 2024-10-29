"use strict";

module.exports = {
  up: (queryInterface, Sequelize) => {
    /*
      Add altering commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      */
    return queryInterface.bulkInsert(
      "KPMGFunctions",
      [
        {
          name: "forensic",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "FRM",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Failed Test",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "D&A",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Audit-CM",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Audit-FSI",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Audit-ENR",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Audit-DPP",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "MC",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "Deal Advisory",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "IARCS",
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: "TRPS-CM",
          createdAt: new Date(),
          updatedAt: new Date()
        }
      ],
      {}
    );
  },

  down: (queryInterface, Sequelize) => {
    /*
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.bulkDelete('People', null, {});
    */
  }
};
