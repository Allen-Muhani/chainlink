// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {
    ILogAutomation,
    Log
} from "chainlink-brownie-contracts/contracts/src/v0.8/automation/interfaces/ILogAutomation.sol";

/**
 * @title Chainlink update the counter automatically by listening to logs.
 * @author Allen Muhani
 * @notice Example contract demonstrating Chainlink Log Automation.
 *  @dev This contract listens for logs via Chainlink Automation and
 *   increments a counter each time a qualifying log is detected.
 */
contract CountWithLogs is ILogAutomation {
    event CountedBy(address indexed msgSender);

    uint256 public counted = 0;

    constructor() { }

    /**
     * @notice Determines whether a detected log should trigger an upkeep.
     * @dev Called off-chain by Chainlink Automation nodes when a matching
     *      log is observed. This function must be deterministic and MUST NOT
     *      modify contract state.
     *
     *      In this example, every detected log triggers an upkeep.
     *      The sender address is extracted from the log topics and passed
     *      to performUpkeep via performData.
     *
     * @param log The log that triggered the Automation check.
     * param checkData Arbitrary data supplied at registration time (unused).
     *
     * @return upkeepNeeded Always true in this example.
     * @return performData ABI-encoded sender address extracted from the log.
     */
    function checkLog(Log calldata log, bytes memory)
        external
        pure
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        upkeepNeeded = true;
        address logSender = bytes32ToAddress(log.topics[1]);
        performData = abi.encode(logSender);
    }

    /**
     * @notice Executes the automated upkeep.
     * @dev Called on-chain by the Chainlink Automation Registry after
     *       checkLog returns upkeepNeeded = true.
     *
     *       This function increments the counter and emits an event
     *       containing the address extracted from the triggering log.
     *
     * @param performData ABI-encoded data returned by checkLog.
     */
    function performUpkeep(bytes calldata performData) external override {
        counted += 1;
        address logSender = abi.decode(performData, (address));
        emit CountedBy(logSender);
    }

    /**
     *
     * @notice Converts a bytes32 value into an Ethereum address.
     * @dev Used to extract indexed address parameters from log topics.
     *
     * @param _address The bytes32 value containing the address.
     * @return The extracted Ethereum address.
     */
    function bytes32ToAddress(bytes32 _address) public pure returns (address) {
        return address(uint160(uint256(_address)));
    }

    /**
     * Gets the number of calls by chainlink log automation.
     */
    function getCount() external view returns (uint256) {
        return counted;
    }
}
