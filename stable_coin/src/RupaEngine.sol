// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RupaStableCoin} from "./RupaCoin.sol";
import {ReentrancyGuard} from "openzeppelin/contracts/security/ReentrancyGuard.sol";
/*
* @title RupaEngine
* @author 0xtenma
* This is the system designed to be minimal as possible, and have the tokens maintain 1INR = 1 Coin Peg
* @notice This is the core contract of the Rupa stable coin. It handles all the logic for minting and redeeming Rupa, as well as depositing & withdrawing collateral

*/

contract RupaEngine() {
    /* Errors */
    error RupaEngine__NeedsMoreThanZero();
    error RupaEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
    error RupaEngine__NotAllowedToken();

    /* State Variables */
    mapping(address token => address priceFeed) private s_priceFeeds;
    RupaStableCoin private immutable i_rupa; 
    mapping(address usder => mapping(address token => uint256 amount)) private s_collateralDeposited;
    
    /* Emitts */

    /* Modifiers */
    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert RupaEngine__NeedsMoreThanZero();
        }
    }
    
    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert RupaEngine__NotAllowedToken();
        }
    }
    /* Functions */
    constructor(
        address[] memory tokenAddresses,
        address[] memory priceFeedAddresses,
        address rupaAddress,
    ) {
        if (tokenAddresses.length != priceFeedAddresses.length){
            revert RupaEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
        }

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddress[i];
        }
        i_rupa = RupaStableCoin(rupa_address);
    }
    function depositCollateralAndMintRupa() external {}
    
    function depositCollateral(
        address tokenCollateralAddress, 
        uint256 amountCollateral) 
        external
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
         {
            s_collateralDeposited[msg.sender][tokenColleralAddress] += amountColleteral;

            emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
    }

    function redeemCollateral() external {}

    function mintRupa() external {}

    function burnRupa() external {}

    function redeemCollateralForRupa() external {}

    function burnRupa() external {}
    
    function liquidate() external {}

}