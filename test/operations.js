var Lottery = artifacts.require("./Lottery.sol");
var lottery = Lottery.deployed();

contract('Operations', function() {
  it("should issue refunds when killed", function() {
    return lottery.then(function(instance) {
    });
  });
});
