const EthStaking = artifacts.require("EthStaking");

module.exports = function (deployer) {
  deployer.deploy(EthStaking);
};
