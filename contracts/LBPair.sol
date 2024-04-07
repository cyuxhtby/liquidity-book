// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ILBPair} from "./interfaces/ILBPair.sol"; 

contract LBPair is ILBPair {

    modifier onlyFactory(){
        if(msg.sender != _factory) revert LBPair__OnlyFactory();
        _;
    }
    
    uint256 private constant _MAX_TOTAL_FEE = 0.1e18; // 10%

    address private _factory;

    // encoded market settings that got passed into initialize()
    bytes32 private _parameters;

    // encoded aggregated total of both assets accross all bins
    bytes32 private _reserves;

    bytes32 private _protocolFees;

    // the encoded total of both assets for a single bin
    mapping(uint256 binId => bytes32 encodedReserves) private _bins; 


    // tree math placeholder
    // oracle helper placeholder

    constructor(address factory){
        _factory = factory;
        // prevents direct calls to `initialize` after cloning, ensuring it's only called once by the factory
        _parameters = bytes32(uint256(1));  
    }

    // sets market fee settings settings
    // determines the cost structure for trading, fees, and providing liquidity within the pool
    // these can be dynamically updated post-market creation to adapt to market conditions

    // reference volatility updates to the current volatility decayed by the reductionFactor R when t is greater than the filterPeriod (tf),
    // or it completely resets to 0 when t is greater than the decayPeriod (td).
    function initialize(
        uint16 baseFactor, // the base factor for the static fee
        uint16 filterPeriod, // the filter period for the static fee
        uint16 decayPeriod, // the decay period for the static fee 
        uint16 reductionFactor, // the reduction factor for the static fee
        uint24 variableFeeControl, // the variable fee control for the static fee
        uint16 protocolShare, // the protocol share for the static fee
        uint16 maxVolatilityAccumulator, // the max volatility accumulator for the static fee
        uint16 activeId // the active id of the LB pair
    ) external /*override*/ onlyFactory {
        bytes32 parameters = _parameters;
        if (parameters != 0) revert LBPair__AlreadyInitialized();

            // set static fee parameters
            // parameters.setActiveId(activeId).updateIdReference(),
            // baseFactor,
            // filterPeriod,
            // decayPeriod,
            // reductionFactor,
            // variableFeeControl,
            // protocolShare,
            // maxVolatilityAccumulator
    }

}