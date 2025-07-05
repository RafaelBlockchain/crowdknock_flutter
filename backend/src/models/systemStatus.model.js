// backend/src/models/systemStatus.model.js
module.exports = (sequelize, DataTypes) => {
  const SystemStatus = sequelize.define('SystemStatus', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    cpuUsage: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    memoryUsage: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    uptime: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    statusMessage: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    isHealthy: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
  }, {
    tableName: 'system_status',
    timestamps: true,
  });

  return SystemStatus;
};
