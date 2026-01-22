// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Count Emit Log
 * @author Allen Muhani
 * @notice emmits logs to be used by chainlink for autoamted calls.
 */
contract CountEmitLog {
    event WantsToCount(address indexed msgSender);

    constructor() { }

    /**
     * Just emits the expected log.
     */
    function emitCountLog() external {
        emit WantsToCount(msg.sender);
    }
}

