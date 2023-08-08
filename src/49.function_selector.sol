// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
    }
}