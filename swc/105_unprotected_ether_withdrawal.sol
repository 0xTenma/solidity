// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
Due to missing or insufficient access controls, malicious parties can withdraw some or all Ether from the contract account.

This bug is sometimes caused by unintentionally exposing initialization functions. 
By wrongly naming a function intended to be a constructor, the constructor code ends up in the runtime byte code and can be called by anyone to re-initialize the contract.

*/

contract SimpleWallet {
    mapping(address => uint256) public balances;

    constructor() public {
        balances[msg.sender] = 1 ether;
    }

    function withdraw() public {
        msg.sender.transfer(balances[msg.sender]);
        balances[msg.sender] = 0;

    }
}

/*
Anyone can call the withdraw function and siphon off all ehter held in the contract without any authorization
check.
*/