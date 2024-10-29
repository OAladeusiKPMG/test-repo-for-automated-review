"use strict";

module.exports = {
  up: (queryInterface, Sequelize) => {
    /*
      Add altering commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.bulkInsert('People', [{
        name: 'John Doe',
        isBetaMember: false
      }], {});
    */
    return queryInterface.bulkInsert("Users", [
      {
        username:"user1",
        password:"Password12*",
        firstName: "user1",
        lastName: "user1",
        email: "user1@ng.kpmg.com",
        division:"audit",
        unit:"audit-cm",
        isDeleted:0,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        username:"user2",
        password:"Password12*",
        firstName: "user2",
        lastName: "user2",
        email: "user2@ng.kpmg.com",
        division:"advisory",
        unit:"forensics",
        isDeleted:1,
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ]);
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
