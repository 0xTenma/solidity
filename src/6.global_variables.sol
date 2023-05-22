// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GlobalVariable {
    function globalVars() external view returns(address, uint, uint){
       // global variables
       address sender = msg.sender; // gives the address who calls this function
       uint timestamp = block.timestamp; // gives the timestamp when the function is called
       uint blockNum = block.number;  // gives the current block number
       return (sender, timestamp, blockNum);
    }
}