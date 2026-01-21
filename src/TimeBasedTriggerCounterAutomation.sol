// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
/**
 * @title Counter o experiment with chainlink automation(Time-based)
 * @author Allen Muhani
 * @notice
 */

contract TimeBasedTriggerCounterAutomation {
    /**
     * @dev a simple variable to store how many times chainlink automation called.
     */
    uint256 s_counteVariable = 0;

    /**
     * Simple incrementale method called by chainlink.
     */
    function increase() external {
        s_counteVariable += 1;
    }

    /**
     * Gets the numbeer of times the counter called.
     */
    function getCount() external view returns (uint256) {
        return s_counteVariable;
    }
}
