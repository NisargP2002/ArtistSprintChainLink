// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeed {
    AggregatorV3Interface private _priceFeed;

    constructor(address priceFeedAddress) {
        _priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = _priceFeed.latestRoundData();
        return price;
    }
}