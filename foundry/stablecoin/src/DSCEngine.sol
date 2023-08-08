// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @author  0xTenma
 * @title   DSCEngine
 * @dev     This stablecoin has properties:
 *             - Exogeneous Collateral
 *             - Dollar Pegged
 *             - Algorithmically Stable
 * @notice  This system is designed to be as minimal as  possible, and have the tokens maintain
 *             1 token = 1 $ peg. This contract is the core of DSC system. It handles all the logics.
 */

contract DSCEngine is ReentrancyGuard{
    /*//////////////////////////////////////////////////////////////
                                Errors
    //////////////////////////////////////////////////////////////*/
    error DSCEngine_NeedsMoreThanZero();
    error DSCEngine_TokenAddressesAndPriceFeedAddressesMustBeSameLength();
    error DSCEngine_NotAllowedToken();
    error DSCEngine_TransferFailed();
    error DSCEngine_BreaksHealthFactor(uint256 healthFactor);
    error DSCEngine_MintedFailed();

    /*//////////////////////////////////////////////////////////////
                           State Variables
    //////////////////////////////////////////////////////////////*/
    uint256 private constant ADDITIONAL_FEED_PRECISION = 1e10;
    uint256 private constant PRECISION = 1e18;
    uint256 private constant LIQUIDATION_THRESHOLD = 50;
    uint256 private constant LIQUIDATION_PRECISION = 100;
    uint256 private constant MIN_HEALTH_FACTOR = 1;

    mapping(address token => address priceFeed) private _priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private _collateralDeposited;
    mapping(address user => uint256 amountDscMinted) private _dscMinted;

    DecentralizedStableCoin private immutable _dsc;
    address[] private _collateralTokens;
    /*//////////////////////////////////////////////////////////////
                                Events
    //////////////////////////////////////////////////////////////*/
    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);


    /*//////////////////////////////////////////////////////////////
                              Modifiers
    //////////////////////////////////////////////////////////////*/
    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine_NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if(_priceFeeds[token] == address(0)) {
            revert DSCEngine_NotAllowedToken();
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                              Functions
    //////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                             Constructor
    //////////////////////////////////////////////////////////////*/
    constructor(
        address[] memory tokenAddresses,
        address[] memory priceFeedAddress,
        address dscAddress
     ) {
        if(tokenAddresses.length != priceFeedAddress.length) {
            revert DSCEngine_TokenAddressesAndPriceFeedAddressesMustBeSameLength();
        }
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            _priceFeeds[tokenAddresses[i]] = priceFeedAddress[i];
            _collateralTokens.push(tokenAddresses[i]);
        }
        _dsc = DecentralizedStableCoin(dscAddress);
     }
    /*//////////////////////////////////////////////////////////////
                               External Functions
    //////////////////////////////////////////////////////////////*/
    function depositCollateralAndMintDSC() external {}


    /*
    * @notice follows CEI
    * @param tokenCollateralAdress : The address of the token to deposit as collateral
    * @param amountCollateral : The amount of collateral to deposit
    */
    function depositCollateral(
        address tokenCollateralAddress,
        uint256 amountCollateral) 
        external 
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
        {
            _collateralDeposited[msg.sender][tokenCollateralAddres] += amountCollateral;
            emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountColllateral);

            bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this). amountCollateral);
            if(!success) {
                revert DSCEngine_TransferFailed();
            }

        }

    function redeemCollateralForDSC() external {}

    function redeemCollateral() external {}
    /*
    * @notice follows CEI
    * @param amountDscToMin: The amount of decentralized stablecoin to min
    * @notice they must have more collateral value than the minimum threshold
     */
    function mintDSC(uint256 amountDscToMint) external moreThanZero(amountDscMint) nonReentrant
    {
        DSCMinted[msg.sender] += amountDscToMint;
        revertIfHealthFactorIsBroken(msg.sender);

        bool minted = _dsc.mint(msg.sender);
        if(!minted) {
            revert DSCEngine_MintedFailed();
        }
    }

    function burnDSC() external {}

    function liquidate() external {}

    /*//////////////////////////////////////////////////////////////
                     Private & Internal View Functions
    //////////////////////////////////////////////////////////////*/

    function _getAccountInformation(address user) private view returns(
        uint256 totalDscMinted, 
        uint256 collateralValueInUSD) 
    {
        totalDscMinted = DSCMinted[user];
        collateralValueInUSD = getAccountCollateralValue(user);
    }  


    function _healthFactor(address user) private view returns (uint256) {

        (uint256 totalDscMinted, uint256 collateralValueInUSD) = _getAccountInformation();

        uint256 collateralAdjustedForThreshold = (collateralValueInUSD * LIQUIDATION_THRESHOLD) / LIQUIDATION_PRECISION;
        return (collateralAdjustedForThreshold * PRECISION / totalDscMinted);
    }

    function revertIfHealthFactorIsBroken(address user) internal view {
        uint256 userHealthFactor = _healthFactor(user);
        if(userHealthFactor < MIN_HEALTH_FACTOR) {
            revert DSCEngine_BreaksHealthFactor(userHealthFactor);
        }
    }

    /*//////////////////////////////////////////////////////////////
                   Public & External View Functions
    //////////////////////////////////////////////////////////////*/

    function getAccountCollateralValue (address user) public view returns(uint256) {
        for (uint256 i = 0; i<_collateralTokens.length; i++) {
            address token = collateralToken[i];
            uint256 amount = collateralDeposit[user][token];
            totalCollateralValueInUSD += getUSDValue(token, amount);
        }
        return totalCollateralValueInUSD;

    }
    
    function getUSDValue(address token, uint256 amount) public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(_priceFeeds[token]);
        (, int256 price, , ,) = priceFeed.latestRoundData();

        return (uint256(price) * ADDITIONAL_FEED_PRICISION) * amount; // (1000 * 1e8 * 1e10) * 1000 * 1e18(wei )
    }

}
