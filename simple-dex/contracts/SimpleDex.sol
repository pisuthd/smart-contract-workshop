//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// FOR THE WORKSHOP DON'T USE IT OM MAINNET

contract SimpleDex {

    AggregatorV3Interface internal priceFeed;

    IERC20 public linkToken;
    IERC20 public wmaticToken;

    constructor() {
        priceFeed = AggregatorV3Interface(0x5787BefDc0ECd210Dfa948264631CD53E68F7802); // LINK/MATIC 

        linkToken = IERC20(0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39); // CHAINLINK TOKEN ADDRESS
        wmaticToken = IERC20(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270); // WMATIC TOKEN ADDRESS
    }

    // FOR USERS

    function swapLinkToWmatic(uint256 _amount) public {

        // transfer LINK to this contract
        linkToken.transferFrom( address(msg.sender), address(this) , _amount );

        int rate = getCurrentPrice();

        uint256 result = (_amount * uint256(rate)) / (10**18);

        wmaticToken.transfer(msg.sender, result);
    }

    // estimate the output without actual swapping
    function estimateLinkToMatic(uint256 _amount) public view returns (uint256) {
        int rate = getCurrentPrice();

        uint256 result = (_amount * uint256(rate)) / (10**18);

        return result;
    }

    function swapWmaticToLink(uint256 _amount) public {

        // transfer WMATIC to this contract
        wmaticToken.transferFrom( address(msg.sender), address(this) , _amount );

        int rate = (10**36) / getCurrentPrice();

        uint256 result = (_amount * uint256(rate)) / (10**18);

        linkToken.transfer(msg.sender, result);
    }

    // estimate the output without actual swapping
    function estimateWmaticToLink(uint256 _amount) public view returns (uint256) {

        int rate = (10**36) / getCurrentPrice();

        uint256 result = (_amount * uint256(rate)) / (10**18);

        return result;
    }

    function getCurrentPrice() public view returns (int) {
        (
            , 
            int price,
            ,
            ,
        ) = priceFeed.latestRoundData();
        return price;
    }


    // FOR SUPPLIERS

    function currentLinkBalance() public view returns (uint256) {
        return linkToken.balanceOf(address(this));
    }

    function currentWmaticBalance() public view returns (uint256) {
        return wmaticToken.balanceOf(address(this));
    }

    function depositLink(uint256 _amount) public {
        linkToken.transferFrom( address(msg.sender), address(this) , _amount );
    }

    function depositWmatic(uint256 _amount) public {
        wmaticToken.transferFrom( address(msg.sender), address(this) , _amount );
    }   

    function withdrawLink(uint256 _amount) public {
        linkToken.transfer(msg.sender, _amount);
    }

    function withdrawWmatic(uint256 _amount) public {
        wmaticToken.transfer(msg.sender, _amount);
    }
    
}
