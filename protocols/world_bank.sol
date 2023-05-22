// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HelloWorldBank{
    address payable owner;
    mapping(address => uint) private balances;

    constructor () public payable {
        owner = payable(msg.sender);
    }

    function isOwner() public view returns(bool){
        return payable(msg.sender) == owner;
    }
    modifier onlyOwner(){
        require(isOwner());
        _;
    }
    
    function deposit() public payable {
        require((balances[msg.sender]+ msg.value) >= balances[msg.sender]);
    }
    function withdraw(uint withdrawAmount) public {
        require(withdrawAmount <= balances[msg.sender]);

        balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
    }

    function withdrawAll() public onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }
    
    function getBalance() public view returns(uint){
        return balances[msg.sender];
    }
}