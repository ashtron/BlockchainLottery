var Lottery = artifacts.require("./Lottery.sol");

var Web3 = require("../node_modules/web3/");
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

module.exports = function(deployer) {
  var maxParticipants = 5;
  var ticketPrice = 1000;

  deployer.deploy(Lottery, maxParticipants, ticketPrice, { from: web3.eth.accounts[0], value: 100000 });
};
