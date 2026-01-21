// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import {
    TimeBasedTriggerCounterAutomation
} from "../../src/TimeBasedTriggerCounterAutomation.sol";

/**
 * @title Counts how many times the time based automation call has been triggered.
 * @author Allen Muhani
 * @notice forge script script/simple-time-based-automation-contract-scripts/Interactions.s.sol:TimeBasedTriggerCounterAutomationGetCounter is Script   --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast
 */
contract TimeBasedTriggerCounterAutomationGetCounter is Script {
    
    function getCount(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        uint256 count =
            TimeBasedTriggerCounterAutomation(mostRecentlyDeploy).getCount();
        vm.stopBroadcast();

        console.log("Count is currently at  ", count);
    }

    function run() external {
        address mostRcentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TimeBasedTriggerCounterAutomation", block.chainid
        );
        getCount(mostRcentlyDeployed);
    }
}
