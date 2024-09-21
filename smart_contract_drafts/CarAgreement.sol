// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CarAgreement {
    address public partyA;
    address public partyB;
    uint256 public carId;
    uint256 public agreedMileage;
    bool public conditionMet;
    bool public agreementExecuted;

    AggregatorV3Interface internal mileageFeed;

    constructor(
        address _partyA,
        address _partyB,
        uint256 _carId,
        uint256 _agreedMileage,
        address _mileageFeed
    ) {
        partyA = _partyA;
        partyB = _partyB;
        carId = _carId;
        agreedMileage = _agreedMileage;
        mileageFeed = AggregatorV3Interface(_mileageFeed);
    }

    function checkMileage() public {
        (
            , 
            int price,
            ,
            ,
            
        ) = mileageFeed.latestRoundData();
        require(price >= 0, "Invalid mileage data");
        if (uint256(price) <= agreedMileage) {
            conditionMet = true;
        }
    }

    function executeAgreement() public {
        require(conditionMet, "Conditions not met");
        require(!agreementExecuted, "Agreement already executed");
        // Transfer ownership logic
        agreementExecuted = true;
    }
}
