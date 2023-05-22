// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// immutable also saves the gas

/*
immutable variables are like constants except that 
we can only initialize this when the contract is deployed.
*/
contract Immutable {
    address public immutable owner = msg.sender;

    // constructor() {
    //     owner = msg.sender;
    // }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}  