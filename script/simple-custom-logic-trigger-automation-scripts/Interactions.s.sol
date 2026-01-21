// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { Counter } from "../../src/Counter.sol";

/**
 * @title Get the numer of times the automation calls have happened.
 * @author Allen Muhani
 * @notice forge script script/simple-custom-logic-trigger-automation-scripts/Interactions.s.sol:CounterGetCount   --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast
 */
contract CounterGetCount is Script {
    function getCount(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        uint256 count = Counter(mostRecentlyDeploy).getCount();
        vm.stopBroadcast();

        console.log("Count is currently at  ", count);
    }

    function run() external {
        address mostRcentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "CustomLogicCounterTrigger", block.chainid
        );
        getCount(mostRcentlyDeployed);
    }
}
