module.exports = (sequelize, DataTypes) => {
  const SystemStatus = sequelize.define(
    'SystemStatus',
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
      },
      cpuUsage: {
        type: DataTypes.FLOAT,
        allowNull: false,
        field: 'cpu_usage',
      },
      memoryUsage: {
        type: DataTypes.FLOAT,
        allowNull: false,
        field: 'memory_usage',
      },
      uptime: {
        type: DataTypes.BIGINT,
        allowNull: false,
      },
      statusMessage: {
        type: DataTypes.STRING,
        allowNull: true,
        field: 'status_message',
      },
      isHealthy: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
        field: 'is_healthy',
      },
    },
    {
      tableName: 'system_status',
      timestamps: true,
      underscored: true,
    }
  );

  return SystemStatus;
};
