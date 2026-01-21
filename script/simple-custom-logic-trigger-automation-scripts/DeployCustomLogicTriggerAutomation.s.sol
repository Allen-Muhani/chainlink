// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import {
    CustomLogicCounterTrigger
} from "../../src/CustomLogicCounterTrigger.sol";

/**
 * @title Deploys a simple custom logic trigger automation.
 * @author Allen Muhani
 * @notice forge script script/simple-custom-logic-trigger-automation-scripts/DeployCustomLogicTriggerAutomation.s.sol   --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast   --verify   --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployCustomLogicTriggerAutomation is Script {
    function run() external returns (CustomLogicCounterTrigger) {
        vm.startBroadcast();
        CustomLogicCounterTrigger customLogicUpKeep =
            new CustomLogicCounterTrigger(60);
        vm.stopBroadcast();
        return customLogicUpKeep;
    }
}
