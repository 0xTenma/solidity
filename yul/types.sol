// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract YulTypes { 
    function getNumber() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 42
        }
        return x;
    }

    function getHex() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 0xa
        }
        return x;
    }

    function getString external pure returns (string memory) {
        bytes32 x = "";

        assembly {
            x := "Hello world"
        }
        return string(abi.encode(x));
    }

    function representation() external pure returns (bool) {
        bool x;

        assembly {
            x := 1
        }
        return x;
    }
}