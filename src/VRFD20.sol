// SPDX-License-Identifier: MIT

// https://docs.chain.link/vrf/v2-5/getting-started
// https://remix.ethereum.org/#url=https://docs.chain.link/samples/VRF/v2-5/VRFD20.sol&autoCompile=true&lang=en&optimize&runs=200&evmVersion&version=soljson-v0.8.31+commit.fd3a2265.js
// https://docs.chain.link/vrf/v2-5/supported-networks#configurations

pragma solidity ^0.8.0;

import { VRFConsumerBaseV2Plus } from
    "chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

contract VRFD20 is VRFConsumerBaseV2Plus {
    uint256 public s_subscriptionId;

    constructor(uint256 subscriptionId, address vrfCoordinator)
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        s_subscriptionId = subscriptionId;
    }
}
