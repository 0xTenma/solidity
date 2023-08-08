// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Error {
    error NotAuthorized();

    function throwError() external pure {
        require(false, "not authorized");
    }

    function throwCustomError() external pure {
        revert NotAuthorized();
    }
}
