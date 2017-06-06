var Lottery = artifacts.require("./Lottery.sol");
var lottery = Lottery.deployed();

contract('Initialization', function() {
  it("should have the right number of max participants", function() {
    return lottery.then(function(instance) {
       assert(instance.maxParticipants, 5, "wrong number of max participants");
    });
  });

  it("should have the right ticket price", function() {
    return lottery.then(function(instance) {
       assert(instance.ticketPrice, 1000, "wrong ticket price");
    });
  });

  it("should add the contract deployer as the first participant", function() {
    return lottery.then(function(instance) {
       return instance.getParticipantData.call(0);
    }).then(function(firstParticipant) {
      assert.equal(firstParticipant[0], web3.eth.accounts[0], "contract deployer was not added as a participant");
    });
  });
});
