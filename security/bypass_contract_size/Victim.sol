// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.10;

contract Victim {
    function isContract(address account) public view returns (bool) {
        uint size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "No contract allowed");
        pwned = true;
    }
}