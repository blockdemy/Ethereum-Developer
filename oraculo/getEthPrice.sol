


// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract getEthPrice {
    AggregatorV3Interface internal priceFeed;
     address constant priceAddress = 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e ;
    /**
     * Network: RINKEBY
     * Aggregator: ETH/USD
     * Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(priceAddress);
    }

    function getLatestEthPrice() public view returns( uint80 , int256 , uint256 , uint256 , uint80 ){
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return (  roundId,  answer,  startedAt, updatedAt, answeredInRound);
    } 

    function getOnlyEthPrice() public view returns( int256 ){
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return answer;
    } 

}
