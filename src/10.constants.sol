// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 21442 gas
contract Constants {
    address public constant MY_ADDRESS = 0x197d0581BD41598feC5A2F6b079582F808653d6c;
    uint public constant MY_UINT = 123;   
}
// 23553 gas
contract Var {
    address public MY_ADDRESS = 0x197d0581BD41598feC5A2F6b079582F808653d6c;
 
}