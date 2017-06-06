var Lottery = artifacts.require("./Lottery.sol");

contract('Lottery', function() {
  it("should have the right number of max participants", function() {
    return Lottery.deployed().then(function(instance) {
       assert(instance.maxParticipants, 5, "wrong number of max participants");
    });
  });

  it("should have the right ticket price", function() {
    return Lottery.deployed().then(function(instance) {
       assert(instance.ticketPrice, 1000, "wrong ticket price");
    });
  });

  it("should add the contract deployer as a participant", function() {
    return Lottery.deployed().then(function(instance) {
       return instance.participants.call(0);
    }).then(function(firstParticipant) {
      assert.equal(firstParticipant.addr, web3.eth.accounts[0], "contract deployer was not added as a participant");
    });
  });
});
