// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20Burnable, ERC20} from "openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin/contracts/access/Ownable.sol";

/*
* @title RupaCoin
* @author 0xtenma
* Collateral: Exogenous (ETH, BTC)
* Minting: Algorithmic
* Relative Stability: Pagged to INR
* This is the contract which implements the ERC20 token implement for the stablecoin.
*/
contract RupaStableCoin {
    error Rupa__MustBeMoreThanZero();
    error Rupa__BurnAmountExceedsBalance();
    error Rupa__NotZeroAddress();

    contrustor() ERC20("Rupa", "ERP"){
    }
    
    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount < 0) {
            revert Rupa__MustBeMoreThanZero();
        }
        if (balance < _amount){
            revert Rupa__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool) {
        if (_to == address(0)) {
            revert Rupa__NotZeroAddress();
        }
        if (_amount < 0) {
            revert Rupa__MustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}