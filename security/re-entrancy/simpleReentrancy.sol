// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Vault {
    error NativeTokenTransferError();

    mapping(address => uint256) balances;

    function deposit() payable external {
        balances[msg.sender] = msg.value;
    }

    function withdraw() external {
        (bool sent, ) = payable(msg.sender).call{value: balances[msg.sender]}("");
        if (!sent) revert NativeTokenTransferError();
        delete balances[msg.sender];
    }
}