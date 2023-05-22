// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// sload(slot) gives the values of slot
// sstore(slot, value) stores the value in a slot
// (variable name).slot

contract StorageBasics {
    uint256 x = 2;
    uint256 y = 3;
    uint256 z = 4;
    uint256 p; // p is hardcoded to see the slot
    uint128 a = 1; // variable packing
    uint128 b = 2;

    function getSlot() external pure returns (uint256 slot) {
        assembly {
            slot := b.slot
        }
    }   

    function variablePacking() external pure returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }


    function getP() external view returns (uint256) {
        return p; //p.slot 
    }

    function getXYul() external view returns(uint256 ret){
        assembly {
            ret := sload(x.slot)
        }
    }

    function setX(uint256 newVal) external {
        x = newVal'
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function getVarYul(uint256 slot) external view return(uint256 ret){
        assembly {
            ret := sload(slot)
        }
    }

    function setVarYul(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value)
        }
    }
}