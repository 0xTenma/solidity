// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";
import "forge-std/console.sol";

contract TestTime is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.wrap : set block.timestamp to future timestamp
    // vm.roll : set block number
    // skip : increment current timestamp
    // rewind : decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    receive() external payable {}

    function testLogBalance() public {
        console.log("ETH Balance", address(this).balance / 1e18);
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testSendETH() public {
        uint256 bal = address(wallet).balance;

        deal(address(1), 100);
        assertEq(address(1).balance, 10);

        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        deal(address(1), 123);
        vm.prank(address(1));

        _send(123);
        
        hoax(address(1), 456);
        _send(456);

        assertEq(address(wallet).balance, bal + 123 + 456);
    }

    function testBidFailsToBeforeStartTime() public {
        vm.expectRevert(bytes("can't bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("can't bid"));
        vm.warp(startAt + 2 days);

        auction.bid();
    }

    function testTimeStamp() public {
        uint256 t = block.timestamp;

        skip(100);
        assertEq(block.timestamp, t + 100);

        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        console.log("Initial Block Number", block.number);
        vm.roll(999);
        assertEq(block.number, 999);
        console.log("After VM.roll Block Number", block.number);
    }
}
