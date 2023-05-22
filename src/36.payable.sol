// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// by declaring the variable as payable now they can send ether.

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {} // without payable this function can't receive ether.

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}