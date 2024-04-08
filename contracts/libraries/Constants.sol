// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/**
 * @title Liquidity Book Constants Library
 * @author Trader Joe
 * @notice Set of constants for Liquidity Book contracts
 */

/// @dev PRECISION and SCALE_OFFSET set scene for precision math, this exceeds the euint32 capacity

library Constants {
    uint8 internal constant SCALE_OFFSET = 128; // the exponential constant used to derive SCALE
    uint256 internal constant SCALE = 1 << SCALE_OFFSET; // left bit shift, essentially 2^128

    uint256 internal constant PRECISION = 1e18; // standard 18 decimal precision
    uint256 internal constant SQUARED_PRECISION = PRECISION * PRECISION;

    uint256 internal constant MAX_FEE = 0.1e18; // 10%
    uint256 internal constant MAX_PROTOCOL_SHARE = 2_500; // 25% of the fee

    uint256 internal constant BASIS_POINT_MAX = 10_000; // scaling factor for percentages expressed in basis points (1% = 100 basis points)

    /// @dev The expected return after a successful flash loan
    bytes32 internal constant CALLBACK_SUCCESS = keccak256("LBPair.onFlashLoan");
}