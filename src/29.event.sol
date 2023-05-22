// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Event {
    event Log(string message, uint val);

    /*
    indexed will store it as a topic in the log record. Without the keyword "indexed", it will be stored as data.
    Upto 3 parameters it can index
    
    */
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("foo", 12334);
        emit IndexedLog(msg.sender, 893);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
