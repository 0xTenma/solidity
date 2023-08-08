// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
The return value of a message call is not checked.
Execution will resume even if the called contract throws an exception.
If the call fails accidentally or an attacker forces the call to fail, this may cause unexpected behaviour in the subsequent program logic.

REMEDIATION
If you choose to use low-level call methods, make sure to handle the possibility 
that the call with fail by checking the return value.
*/


contract ReturnValue {
    function callChecked(address callee) public {
        require(callee.call(), " ");
    }

    function callNotChecked(address callee) public {
        callee.call();
    }
}