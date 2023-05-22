// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IsPrime {

    function isPrime(uint256) public pure returns (bool p) {
        p = true;
        assembly { 
            let halfX := add(div(x. 2), 1) // uint256 halfX = x/2 + 1;
            for { let i := 2 } lt(i, halfX) { i := add(i, 1) }
            {
                if iszero(mod(x, i)) {
                    p := 0
                    break
                }
            }
        }
    }

    function testPrime() external pure {
        require(isPrime(2));
        require(isPrime(3));
        require(isPrime(4));
        require(isPrime(14));
    }
}

contract IfComparison {
    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            if 2 {
                result := 2
            }
        }
        return result;
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if 0 {
                result := 2
            }
        }
        return result;
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }
        return result;
    }

    function bitFlip() external pure returns (bytes32 result) {
        assembly {
            result := not(2)
        }

        return result;
    }

    function unsafe1NegationPart() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(0) {
                result := 2
            }
        }

        return result;
    }

    function unsafe2NegationPart() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(2) {
                result := 2
            }
        }

        return result;
    }

    function maxOfTwo(uint256 x, uint256 y) external pure returns (uint256 max) {
        assembly {
            if lt(x, y) {
                max := y
            }
            if iszero(lt(x, y)) {  // if negation is true
                max := x
            }
        }
    }

}