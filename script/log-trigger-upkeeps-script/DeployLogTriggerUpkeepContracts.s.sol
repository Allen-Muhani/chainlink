// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { CountEmitLog } from "../../src/log-trigger-upkeeps/CountEmitLog.sol";
import { CountWithLogs } from "../../src/log-trigger-upkeeps/CountWithLogs.sol";

/**
 * @title Log emitter (CountEmitLog) to trigger chainlink automated call to  CountWithLogs
 * @author Allen Muhani
 * @notice forge script script/log-trigger-upkeeps-script/DeployLogTriggerUpkeepContracts.s.sol   --rpc-url $SEPOLIA_RPC_URL   --private-key $PRIVATE_KEY   --broadcast   --verify   --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployCustomLogicTriggerAutomation is Script {
    function run()
        external
        returns (CountEmitLog countEmitLog, CountWithLogs coutWithLogs)
    {
        vm.startBroadcast();
        countEmitLog = new CountEmitLog();
        coutWithLogs = new CountWithLogs();
        vm.stopBroadcast();
    }
}
