const EthStaking = artifacts.require("Eth_Staking");

module.exports = function (deployer) {
  deployer.deploy(EthStaking);
};
