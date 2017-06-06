// configurable, transparent ether and erc20 token lottery
// support for any ERC20 token
// add oraclize
// handle oraclize getting shut down
// expiration date (alarm clock)
// what if creator runs out of money for gas fees? (minimum ticket price?)
// allowed addresses option
// allow option to enter automatically or not
// 'ended' bool as in examples
// anyone can cancel but loses gas fees? majority can cancel?
// running lottery with fees
// search for lotteries
// live updates in navbar
// more than one winner
// refunds if someone puts in way too much
// charity lotteries

pragma solidity ^0.4.0;

/*import "./RandomNumberGenerator.sol";*/

contract Lottery {
  struct Participant {
    address addr;
    uint gas;
  }

  address creator;
  Participant[] public participants;
  uint public maxParticipants;
  uint public ticketPrice;
  address winner;
  bool ended;
  string public rand;

  event DrawingComplete(address winner, uint amount);
  event TicketPurchased(address participant);

  function Lottery(uint _maxParticipants, uint _ticketPrice) payable {
    // Allow extra for gas prices in case of cancellation.
    require(msg.value >= ticketPrice);
    ended = false;

    maxParticipants = _maxParticipants;
    ticketPrice = _ticketPrice;

    participants.push(Participant({
      addr: msg.sender,
      gas: 0
    }));

    TicketPurchased(msg.sender);
  }

  function enter() payable returns (bool) {
    /*require (msg.value == ticketPrice);*/
    // One ticket per address.
    for (var i = 0; i < participants.length; i++) {
      if (participants[i].addr == msg.sender) {
        return false;
      }
    }

    participants.push(Participant({
      addr: msg.sender,
      gas: msg.gas
    }));

    if (participants.length == maxParticipants) {
      draw();
    }

    TicketPurchased(msg.sender);

    return true;
  }

  function length() constant returns(uint) {
    return participants.length;
  }

  function getParticipantData(uint index) public constant returns(address, uint) {
    return (participants[index].addr, participants[index].gas);
  }

  function draw() {
    // get random number
    uint rando = 4;
    address winner = participants[rando].addr;

    DrawingComplete(winner, this.balance);
    winner.transfer(this.balance);
    ended = true;
  }

  function kill() {
    // Distribute refunds; deduct gas costs
    // from creator's refund.
    for (var i = 1; i < participants.length; i++) {
      participants[i].addr.transfer(ticketPrice + participants[i].gas);
    }

    selfdestruct(creator);
  }
}
