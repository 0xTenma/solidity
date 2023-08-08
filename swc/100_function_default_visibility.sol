pragma solidity ^0.8.8;

contract HashForEther {
    function withdrawWinnings() {
        require(uint32(msg.sender) == 0);
        _sendWarnings(); 
    }

    function _sendWarnings() {
        msg.sender.transfer(this.balance);
    }
}