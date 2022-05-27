const USDCMigrations = artifacts.require("devUSDC");

module.exports = function (deployer) {
  deployer.deploy(USDCMigrations);
};
