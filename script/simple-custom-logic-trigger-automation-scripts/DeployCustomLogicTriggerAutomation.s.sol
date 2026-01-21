// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import {
    CustomLogicCounterTrigger
} from "../../src/CustomLogicCounterTrigger.sol";

contract DeployCustomLogicTriggerAutomation is Script {
    function run() external returns (CustomLogicCounterTrigger) {
        vm.startBroadcast();
        CustomLogicCounterTrigger customLogicUpKeep =
            new CustomLogicCounterTrigger(60);
        vm.stopBroadcast();
        return customLogicUpKeep;
    }
}
