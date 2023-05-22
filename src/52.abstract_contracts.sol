// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// unimplemented functions can exist in contract 

abstract contract base {
    uint public num;
    
    function call() public pure returns(uint) {
        return 1;   
    }

    function call2() public pure virtual returns(uint);
    
}

contract Main is base {
    function call1() public pure override returns(uint){
        return 1;
    }
}