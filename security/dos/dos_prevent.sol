// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Use push vs pull strategy to prevent dos attacks

contract KingOfEther {
    address public king;
    uint public balance;
    mapping(address => uint) public balances;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more become the king");

        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    function withdraw() public {
        require(msg.sender != king, "current king cannot withdraw");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{ value: amount}("");
        require(sent, "failed to send ether"); 
    }
}

