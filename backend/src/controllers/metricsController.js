const metricsService = require('../services/metrics.service');

exports.getOverviewMetrics = async (req, res, next) => {
  try {
    const metrics = await metricsService.getOverview();
    res.json({ success: true, data: metrics });
  } catch (error) {
    next(error);
  }
};

exports.getDetailedMetric = async (req, res, next) => {
  try {
    const data = await metricsService.getDetailed(req.params.type);
    res.json({ success: true, data });
  } catch (error) {
    res.status(error.status || 500).json({ success: false, error: error.message });
  }
};
