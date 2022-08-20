const PlayerContract = artifacts.require("PlayerContract");
const HeroContract = artifacts.require("HeroContract");

module.exports = function (deployer) {
  deployer.deploy(HeroContract);
  deployer.link(HeroContract, PlayerContract);
  deployer.deploy(PlayerContract);
};
