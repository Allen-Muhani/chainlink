// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/// @notice Represents a log emitted by a contract in a transaction.
/// @dev This struct contains important metadata about the log, including
///      the index, timestamp, transaction hash, and additional data.
struct Log {
    /// @notice Index of the log within the block.
    /// @dev This field identifies the order of the log in the block.
    uint256 index;

    // Timestamp of the block containing the log.
    // @dev the time when the block was mined.
    uint256 timestamp;

    /// @notice Represents a log emitted by a contract in a transaction.
    /// @dev This struct contains important metadata about the log, including
    ///      the index, timestamp, transaction hash, and additional data.
    bytes32 txHash;

    /// @notice Block number where the log was created/ number of block containing the log..
    /// @dev The block number represents the position of the block in the blockchain.
    uint256 blockNumber;

    /// @notice Address of the contract that emitted the log.
    /// @dev This address points to the contract (or account) that triggered the log.
    address source;

    /// @notice Array of indexed topics associated with the log.
    /// @dev Topics are used for efficient filtering and searching of logs.
    ///      The first topic is usually the event signature, followed by indexed parameters.
    bytes32[] topics;

    /// @notice Data associated with the log.
    /// @dev This field contains the non-indexed data, usually event arguments or other payload.
    bytes data; // Data of the log.
}

interface ILogAutomation {
    function checkLog(Log calldata log, bytes memory checkData)
        external
        returns (bool upkeepNeeded, bytes memory performData);

    function performUpkeep(bytes calldata performData) external;
}

contract CountWithLog is ILogAutomation {
    event CountedBy(address indexed msgSender);

    uint256 public counted = 0;

    constructor() { }

    function checkLog(Log calldata log, bytes memory checkData)
        external
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        upkeepNeeded = true;
        address logSender = bytes32ToAddress(log.topics[1]);
        performData = abi.encode(logSender);
    }

    function performUpkeep(bytes calldata performData) external override {
        counted += 1;
        address logSender = abi.decode(performData, (address));
        emit CountedBy(logSender);
    }

    function bytes32ToAddress(bytes32 _address) public pure returns (address) {
        return address(uint160(uint256(_address)));
    }
}
