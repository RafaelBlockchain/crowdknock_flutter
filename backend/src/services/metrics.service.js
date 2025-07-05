const { User, Content, Report, Payment } = require('../models');

async function getMetrics() {
  const users = await User.count();
  const contents = await Content.count();
  const reports = await Report.count();
  const payments = await Payment.count();

  return { users, contents, reports, payments };
}

module.exports = { getMetrics };
