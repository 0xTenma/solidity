// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// data locations - storage, memory and calldata

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] memory y, string memory s) external returns (MyStruct memory) {
        myStructs[msg.sender] = MyStruct({
            foo: 123, text: "bar"
        });

        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        return readOnly;
    }
}
