// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import {
    TimeBasedTriggerCounterAutomation
} from "../../src/TimeBasedTriggerCounterAutomation.sol";

/**
 * @title Deploys a simple custom logic trigger automation.
 * @author Allen Muhani
 * @notice forge script script/simple-time-based-automation-contract-scripts/DeployTimeBasedTriggerCounterAutomation.sol   --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast   --verify   --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployTimeBasedTriggerCounterAutomation is Script {
    function run() external returns (TimeBasedTriggerCounterAutomation) {
        vm.startBroadcast();
        TimeBasedTriggerCounterAutomation timeBasedTriggerAutomation =
            new TimeBasedTriggerCounterAutomation();
        vm.stopBroadcast();
        return timeBasedTriggerAutomation;
    }
}
