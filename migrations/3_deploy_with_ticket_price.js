var Lottery = artifacts.require("./Lottery.sol");

module.exports = function(deployer) {
  var maxParticipants = 5;
  var ticketPrice = 1000;

  deployer.deploy(Lottery, maxParticipants, ticketPrice, { from: web3.eth.accounts[0], value: 100000 });
};
