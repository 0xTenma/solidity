// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayReplaceLast {
    uint[] public arr;


    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function removeShift(uint _inx) public {
        require(_inx < arr.length, "index out of bound");

        for(uint i = _inx; i < arr.length - 1; i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }
    function test() external {
        arr = [1, 2, 3, 4];

        remove(1);
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
     
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}