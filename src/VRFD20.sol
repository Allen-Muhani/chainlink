// SPDX-License-Identifier: MIT

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
