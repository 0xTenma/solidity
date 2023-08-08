// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Event.sol";

contract EventTest is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        e = new Event();
    }

    function testEmitTransferEvent() public {
        // function expectEmit(
        // bool checkTopic1,
        // bool checkTopic2,
        // bool checkTopic3,
        // bool checkData
        // ) external;
        // 1. tell foundry which data to check
        // Check index 1, index 2 and data

        vm.expectEmit(true, true, false, true);

        // 2. Emit the expected Event
        emit Transfer(address(this), address(123), 234);

        // 3. Call the function that should emit the event
        e.transfer(address(this), address(123), 234);

        // check only index 1
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(123), 234);
        // Note: index 2 and data (amount) doesn't match
        // but the test will pass

        e.transfer(address(this), address(111), 222);
    }

    function testEmitManyTransferEvent() public {
        address[] memory to = new address[](2);
        to[0] = address(111);
        to[1] = address(222);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 12;
        amounts[1] = 34;

        for (uint256 i = 0; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }

        e.transferMany(address(this), to, amounts);
    }
}
