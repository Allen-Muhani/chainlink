// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { CountEmitLog } from "../../src/log-trigger-upkeeps/CountEmitLog.sol";
import { CountWithLogs } from "../../src/log-trigger-upkeeps/CountWithLogs.sol";

/**
 * @title Get the numer of times the automation calls have happened.
 * @author Allen Muhani
 * @notice forge script script/log-trigger-upkeeps-script/Interactions.s.sol:CountEmitLogEmitLog  --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast
 */
contract CountEmitLogEmitLog is Script {
    function emmitLog(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        CountEmitLog(mostRecentlyDeploy).emitCountLog();
        vm.stopBroadcast();

        console.log("event has been emmitted");
    }

    function run() external {
        address mostRcentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "CountEmitLog", block.chainid
        );
        emmitLog(mostRcentlyDeployed);
    }
}

/**
 * @title Get the numer of times the automation calls have happened.
 * @author Allen Muhani
 * @notice forge script script/log-trigger-upkeeps-script/Interactions.s.sol:CountWithLogGetCount  --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast
 */
contract CountWithLogGetCount is Script {
    function getCount(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        uint256 count = CountWithLogs(mostRecentlyDeploy).getCount();
        vm.stopBroadcast();

        console.log("Count is currently at  ", count);
    }

    function run() external {
        address mostRcentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "CountWithLogs", block.chainid
        );
        getCount(mostRcentlyDeployed);
    }
}
