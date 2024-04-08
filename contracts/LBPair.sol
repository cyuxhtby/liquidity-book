// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ILBPair} from "./interfaces/ILBPair.sol"; 
import {PairParameterHelper} from "./libraries/PairParameterHelper.sol";
contract LBPair is ILBPair {
    using PairParameterHelper for bytes32; // manipulates parameter data encoded within a single bytes32 via bitwise operations

    modifier onlyFactory(){
        if(msg.sender != _factory) revert LBPair__OnlyFactory();
        _;
    }
    
    uint256 private constant _MAX_TOTAL_FEE = 0.1e18; // 10%

    address private _factory;

    // holds encoded market settings that get set on initialization
    bytes32 private _parameters;

    // encoded aggregated total of both assets across all bins
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

    /// @notice sets market fee settings
    /// @dev determines the cost structure for trading, fees, and providing liquidity within the pool
    /// @dev these can be dynamically updated post-market creation to adapt to market conditions
    function initialize(
        uint16 baseFactor, 
        uint16 filterPeriod, 
        uint16 decayPeriod, 
        uint16 reductionFactor, 
        uint24 variableFeeControl,
        uint16 protocolShare, 
        uint16 maxVolatilityAccumulator, 
        uint16 activeId // id of active bin
    ) external onlyFactory {
        bytes32 parameters = _parameters;
        if (parameters != bytes32(uint256(1))) revert LBPair__AlreadyInitialized();

        _setStaticFeeParameters(
            parameters,
            baseFactor,
            filterPeriod,
            decayPeriod,
            reductionFactor,
            variableFeeControl,
            protocolShare,
            maxVolatilityAccumulator
        );

        // setActiveId() from PairParameterHelper, places binId to target activeId slot
        _parameters = parameters.setActiveId(activeId);
    }


    /// @notice External function to set static fee parameters of the pool
    /// @dev Can only be called by the factory
    function setStaticFeeParameters(
        uint16 baseFactor,
        uint16 filterPeriod,
        uint16 decayPeriod,
        uint16 reductionFactor,
        uint24 variableFeeControl,
        uint16 protocolShare,
        uint24 maxVolatilityAccumulator
    ) external onlyFactory {
        _setStaticFeeParameters(
            _parameters,
            baseFactor,
            filterPeriod,
            decayPeriod,
            reductionFactor,
            variableFeeControl,
            protocolShare,
            maxVolatilityAccumulator
        );
    }

    /// @dev Sets static fee params with necessary checks
    function _setStaticFeeParameters(
        bytes32 parameters,
        uint16 baseFactor,
        uint16 filterPeriod,
        uint16 decayPeriod,
        uint16 reductionFactor,
        uint24 variableFeeControl,
        uint16 protocolShare,
        uint24 maxVolatilityAccumulator
    ) internal {
        if (
            baseFactor == 0 && filterPeriod == 0 && decayPeriod == 0 && reductionFactor == 0 && variableFeeControl == 0
                && protocolShare == 0 && maxVolatilityAccumulator == 0
        ) {
            revert LBPair__InvalidStaticFeeParameters();
        }

        parameters = parameters.setStaticFeeParameters(
            baseFactor,
            filterPeriod,
            decayPeriod,
            reductionFactor,
            variableFeeControl,
            protocolShare,
            maxVolatilityAccumulator
        );
    }
}