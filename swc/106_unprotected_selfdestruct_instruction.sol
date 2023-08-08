// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
Due to missing or insufficient access controls, malicious parties can self-destruct the contract.

Remediation
Consider removing the self-destruct functionality unless it is absolutely required.
*/

contract SimpleSuicide {
    function sucideAnyone() {
        selfdestruct(msg.sender);
    }
}