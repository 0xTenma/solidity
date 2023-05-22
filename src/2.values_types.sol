// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ValueTypes {
    bool public b = true;
    uint public y = 1234; // uint = uint256 0 to 2**256 - 1
    
    int public i = -134;
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

}