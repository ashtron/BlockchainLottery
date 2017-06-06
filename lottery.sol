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

pragma solidity ^0.4.0;

contract lottery {
    struct Participant {
        address addr;
        uint gas;
    }

    address creator;
    Participant[] participants;
    uint maxParticipants;
    uint ticketPrice;
    address winner;

    event DrawingComplete(address winner, uint amount);
    event TicketPurchased(address participant);

    function lottery(uint _maxParticipants) payable {
        // Allow extra for gas prices in case of cancellation.
        require(msg.value >= ticketPrice);

        maxParticipants = _maxParticipants;
        participants.push(Participant({
            addr: msg.sender,
            gas: 0
        }));
    }

    function enter(address entrant) payable returns (bool) {
        require (msg.value == ticketPrice);
        // One ticket per address.
        for (var i = 0; i < participants.length; i++) {
            if (participants[i].addr == entrant) {
                return false;
            }
        }

        participants.push(Participant({
            addr: entrant,
            gas: msg.gas
        }));

        // TicketPurchased(participant.addr);

        if (participants.length == maxParticipants) {
            draw();
        }
    }

    function draw() {
        // get random number
        uint rando = 4;
        address winner = participants[rando].addr;

        DrawingComplete(winner, this.balance);
        winner.transfer(this.balance);
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
