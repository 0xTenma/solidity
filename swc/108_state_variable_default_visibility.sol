// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
Description
Labeling the visibility explicitly makes it easier to catch incorrect assumptions about who can access the variable.

Remediation
Variables can be specified as being public, internal or private. Explicitly define visibility for all state variabl
*/

contract TestStorage {
    uint storeduin1 = 24;
    uint constant constuint = 25;
    uint32 investmentDeadlineTimeStamp = uint32(now);

    bytes16 
}