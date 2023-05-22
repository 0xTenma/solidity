// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract LocalVariables {
    uint public i;
    bool public b;
    address public myAddress;

    function foo() external pure{

        // local variables
        uint x = 123;
        bool f = false;
        x += 234;
        f = true;
    }
}