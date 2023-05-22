// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StateVariables{
    // state variables will be stored in blockchain
    uint public myUint = 123;

    function foo() external {
        // only exist when the function is executed
        uint notStateVariables = 234;
    }
}