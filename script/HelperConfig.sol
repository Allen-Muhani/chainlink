// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig private activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaConfig();
        }

        // add other networks if need be : https://docs.chain.link/vrf/v2-5/supported-networks#configurations
    }

    function getSepoliaConfig() private pure returns (NetworkConfig memory) {
        return NetworkConfig({
            vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B,
            keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae,
            subscriptionId: 1234
        });
    }

    // Add other network configs if need be : https://docs.chain.link/vrf/v2-5/supported-networks#configurations

    // Other getters
    function getActiveNetworkConfig()
        public
        view
        returns (NetworkConfig memory)
    {
        return activeNetworkConfig;
    }
}

/**
 * @notice A struct containing network configuration details for Chainlink VRF.
 * @param vrfCoordinator The address of the VRF Coordinator contract.
 * @param keyHash the gas lane key hash to use for the VRF requests.
 * @param subscriptionId The subscription ID used to fund VRF requests.
 */
struct NetworkConfig {
    address vrfCoordinator;
    bytes32 keyHash;
    uint64 subscriptionId;
}
