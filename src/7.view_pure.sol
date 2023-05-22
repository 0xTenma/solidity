// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
view function can read data from the blockchain whereas pure function doesn't read anything from the blockchain.
*/

contract ViewPure{
    uint public num;

    // does not modify the state variables and got written to the blockchain, read-only function
    function viewFunc() external view returns(uint){
        return num;
    }

    function pureFunc() external pure returns (uint){
        return 1;
    }

    function addToNum(uint x) external view returns (uint){
        return num + x;
    }

    function add(uint x, uint y) external pure returns (uint){
        return y + x;
    }
}

/*
view function can be declared in which case they promise not to modify the state. they can 
view the state variables but can't modify them.(running that function, no data will be saved/changed.)

pure function declares that no state variable will be changed or read.
pure tells us that not only does the function not save any data to the blockchain, but it also doesn't
read any data from the blockchain.

Both of these don't cost any gas to call if they are called externally from outside the contract.
But they do cost gas if called internally by another function.

*/ 