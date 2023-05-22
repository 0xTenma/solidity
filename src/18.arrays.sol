// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// array - dynamic or fixed size
// initialization
// insert(push), get, update, delete, pop. length
// returning array from function

contract Array {
    uint[] public nums = [1, 2, 3];
    uint[3] public numsFixed = [4, 5, 6];

    function examples() external {
        nums.push(4);
        uint x = nums[1];
        nums[2] = 333;
        delete nums[1];
        nums.pop();
        uint len = nums.length;

        uint[] memory a = new uint[](5);
        a[1] = 123;
        // in memory, no pop and push operations can be perfomed
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}
