/*
   Oraclize random-datasource example

   This contract uses the random-datasource to securely generate off-chain N random bytes
*/

pragma solidity ^0.4.10;

import "./oraclizeAPI.sol";

contract RandomNumberGenerator is usingOraclize {
  string rand;
  event newRandomNumber(bytes);

  function RandomExample() {
    oraclize_setProof(proofType_Ledger); // sets the Ledger authenticity proof in the constructor
  }

  function __callback(bytes32 _queryId, string _result, bytes _proof) oraclize_randomDS_proofVerify(_queryId, _result, _proof) {
    // if we reach this point successfully, it means that the attached authenticity proof has passed!
    if (msg.sender != oraclize_cbAddress()) throw;

    rand = _result;
  }

  function getRandomNumber() payable {
    uint N = 7; // number of random bytes we want the datasource to return
    uint delay = 0; // number of seconds to wait before the execution takes place
    uint callbackGas = 200000; // amount of gas we want Oraclize to set for the callback function
    bytes32 queryId = oraclize_newRandomDSQuery(delay, N, callbackGas); // this function internally generates the correct oraclize_query and returns its queryId
  }
}
