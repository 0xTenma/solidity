// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(isAllowedToWithdraw(msg.sender, amount), "Insufficient balance");

        (bool success, ) = msg.sender.call{value: amount} ("");
        require(success, "Withdraw failed");

        balances[msg.sender] -= amount;
    }

    function isAllowedToWithdraw(address user, uint256 amount) public view returns (bool) {
        return balances[user] >= amount;
    }
}