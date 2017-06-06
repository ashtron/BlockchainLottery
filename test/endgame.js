var Lottery = artifacts.require("./Lottery.sol");
var lottery = Lottery.deployed();

contract('Endgame', function() {
  it("should automatically draw when participants.length == ticketPrice", function() {
    lottery.then(function(instance) {
      for (var i = 1; i < instance.maxParticipants; i++) {
        instance.enter({ from: web3.eth.accounts[i], value: ticketPrice * 100 });
      }

      return instance;
    }).then(function(instance) {
      assert.equal(instance.ended, true, "did not automatically draw");
    });
  });

  it("should not automatically draw when participants.length < ticketPrice", function() {
    lottery.then(function(instance) {
      for (var i = 1; i < instance.maxParticipants - 1; i++) {
        instance.enter({ from: web3.eth.accounts[i], value: ticketPrice * 100 });
      }

      return instance;
    }).then(function(instance) {
      assert.equal(instance.ended, true, "drew too early");
    });
  });

  it("should distribute funds to winner", function() {
    lottery.then(function(instance) {
      for (var i = 0; i < instance.maxParticipants - 1; i++) {
        var addr = web3.eth.accounts[i];
        var value = web3.getBalance(addr);

        instance.enter({ from: addr, value: ticketPrice * 100 });
      }
    }).then(function() {
      var addrs = web3.eth.accounts;

      for (var i = 0; i < 6; i++) {
        assert.equal(web3.eth.getBalance(addrs[i]), 0, "funds distributed incorrectly");
      }

      assert.notEqual(web3.eth.getBalance(addrs[i]), 0, "funds distributed incorrectly");
    });
  });
});
