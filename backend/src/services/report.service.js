const { Report, Content, User } = require('../models');

async function getAllReports() {
  return await Report.findAll({
    include: [Content, User],
    order: [['createdAt', 'DESC']],
  });
}

async function resolveReport(id, resolution) {
  const report = await Report.findByPk(id);
  if (!report) throw new Error('Report not found');
  return await report.update({ resolved: true, resolution });
}

module.exports = { getAllReports, resolveReport };
