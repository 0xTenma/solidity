// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PreventAttack {
    address public owner;

    function transfer(address payable _to, uint256 _amount) public {
        require(msg.sender == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "failed to send ether");
    }
}