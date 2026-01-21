// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { VRFD20 } from "../../src/VRFD20.sol";
import { HelperConfig, NetworkConfig } from "./HelperConfig.s.sol";

contract DeployVDRFD20 is Script {
    function run() external returns (VRFD20) {
        HelperConfig helperConfig = new HelperConfig();

        NetworkConfig memory config = helperConfig.getActiveNetworkConfig();

        vm.startBroadcast();
        VRFD20 vrfd20 = new VRFD20(
            config.subscriptionId, config.vrfCoordinator, config.keyHash
        );
        vm.stopBroadcast();
        return vrfd20;
    }
}
