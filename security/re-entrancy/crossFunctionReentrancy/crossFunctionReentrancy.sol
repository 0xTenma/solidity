// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function withdraw(uint256 amount) external noReentrant {
        uint256 balance = balances[msg.sender];
        require(balance >= amount, "Insufficient balance");

        (bool success, ) = payable(msg.sender).call{value: amount}(" ");
        require(success, "Withdrawal failed");
        
        balances[msg.sender] = balance - amount;
    }

    function transfer(address to, uint256 amount) external {
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}