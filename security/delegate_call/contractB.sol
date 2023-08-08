// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Lib {
    uint public someNumber;

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract HackMe {
    address public lib;
    address public owner;
    uint public someNumer;

    constructor(address _lib) {
        lib = _lib;
        owner = msg.sender;
    }

    function doSomething(uint _num) public {
        (bool success, ) = lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)", _num));
        require(success, "call failed");
    }
}

contract Attack {
    address public lib;
    address public owner;
    uint public someNumber;

    HackMe public hackMe;

    constructor(HackMe _hackMe) {
        hackMe = HackMe(_hackMe);
    }   

    function attack() public {
        owner = msg.sender;
    }
}