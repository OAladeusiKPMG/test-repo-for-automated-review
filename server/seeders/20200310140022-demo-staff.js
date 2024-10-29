"use strict";

const toInsert = async () => {
  const units = ["forensic", "FRM", "D&A", "ITS", "Audit-CM", "Audit-FSI", "Audit-ENR", "Audit-DPP", "MC", "Deal Advisory", "IARCS", "TRPS-CM"];
  const divisions = ["Audit", "Advisory", "Tax", "Central Services"]
  const levels = ["Analyst", "Exp. Analyst", "Associate", "Senior Associate", "Assitance Manager", "Manager", "Senior Manager", "Associate Director", "Partner"];
  const statuss = [0, 1];
  const staffList = []
  let i
  for (i = 0; i < 100; i++) {
    let rdn = Math.floor(Math.random() * 101);
    let unit = units[Math.floor(Math.random() * units.length)];
    var division = divisions[Math.floor(Math.random() * divisions.length)];
    var level = levels[Math.floor(Math.random() * levels.length)];
    var status = statuss[Math.floor(Math.random() * statuss.length)];
    staffList.push({
      personnelId: rdn + 15678389,
      username: "user" + rdn,
      firstName: "John" + rdn,
      lastName: "Carson" + rdn,
      displayName: "Carson" + rdn + ", user" + rdn,
      email: "user" + rdn + ".carson" + rdn + "@ng.kpmg.com",
      unit: unit,
      division: division,
      level: level,
      status: status,
      createdAt: new Date(),
      updatedAt: new Date()
    })

    if (i === 98) {
      return staffList;
    }
  }
}

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const staffListToInsert = await toInsert();
    return queryInterface.bulkInsert("Staffs", staffListToInsert);
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
