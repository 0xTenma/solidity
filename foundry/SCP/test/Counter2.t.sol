// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter2.sol";

contract Counter2Test is Test {
    Counter2 public counter2;

    function setUp() public {
        counter2 = new Counter2();
    }

    function testInc() public {
        counter2.inc();
        assertEq(counter2.count(), 1);
    }

    function testDec() public {
        counter2.inc();
        counter2.dec();
        assertEq(counter2.count(), 0);
    }

    function testFailDec() public {
        counter2.dec();
        assertEq(counter2.count(), 0);
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter2.dec();
    }
}
