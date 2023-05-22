// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// interface allows to call other contract without having the code

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        ICounter(_counter).count();
    }
}