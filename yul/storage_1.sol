// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// offset and bitshifting

contract StoragePart1 {
    uint128 public c = 4;
    uint96 public d = 6;
    uint16 public e = 10;
    uint8 public f = 1;

    function readBySlot(uint256 slot) external view returns(bytes32 value) {
        assembly {
            value := sload(slot)
        }
    }

}