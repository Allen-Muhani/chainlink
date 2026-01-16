// SPDX-License-Identifier: MIT

// https://docs.chain.link/vrf/v2-5/getting-started
// https://remix.ethereum.org/#url=https://docs.chain.link/samples/VRF/v2-5/VRFD20.sol&autoCompile=true&lang=en&optimize&runs=200&evmVersion&version=soljson-v0.8.31+commit.fd3a2265.js
// https://docs.chain.link/vrf/v2-5/supported-networks#configurations

pragma solidity ^0.8.0;

import { VRFConsumerBaseV2Plus } from
    "chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import { VRFV2PlusClient } from
    "chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

contract VRFD20 is VRFConsumerBaseV2Plus {
    /**
     * @notice Emitted when a dice roll is requested.
     * @param requestId The ID of the VRF request.
     * @param roller The address of the account that rolled the dice.
     */
    event DiceRolled(uint256 indexed requestId, address indexed roller);

    /**
     * @notice Emitted when the dice roll lands.
     * @param requestId the request id of the VRF request.(the dice roll that has landed)
     * @param d20Value the value of the D20 dice roll (1-20 in this case).
     */
    event DiceLanded(uint256 indexed requestId, uint256 indexed d20Value);

    /**
     * @notice The subscription ID that this contract uses for funding requests.
     */
    uint256 public s_subscriptionId;

    /**
     * @dev The gas lane to use, which specifies the maximum gas price to bump to.
     * generated via the Chainlink VRF web portal.: https://docs.chain.link/vrf/v2-5/supported-networks#configurations
     */
    bytes32 private immutable I_KEY_HASH;

    /**
     * @dev Indicates that a roll is in progress.
     */
    uint256 private constant ROLL_IN_PROGRESS = 42;

    /**
     * @notice Constructor inherits VRFConsumerBaseV2Plus.
     * @param subscriptionId th subscription used to pay the VRF for dice rolls.
     * @param vrfCoordinator the VRF cordinator for the chain the contract is running on.
     * @param keyHash the gas lane key hash to use for the VRF requests.
     */
    constructor(uint256 subscriptionId, address vrfCoordinator, bytes32 keyHash)
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        s_subscriptionId = subscriptionId;
        I_KEY_HASH = keyHash;
    }

    /**
     * @notice Requests a D20 dice roll from Chainlink VRF.
     * @param roller addres of the account that rolled the dice.
     */
    function rollDice(address roller) public returns (uint256 requestId) {
        // Will revert if subscription is not set and funded.

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: I_KEY_HASH,
                subId: s_subscriptionId,
                requestConfirmations: 3,
                callbackGasLimit: 200000,
                numWords: 1,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        // tells it to pay in LINK tokens instead of eth
                        nativePayment: false
                    })
                )
            })
        );
        // s_results[roller] = ROLL_IN_PROGRESS;
        // s_results[requestId] = roller;
        emit DiceRolled(requestId, roller);
    }

    /**
     * @notice Callback function used by VRF Coordinator.
     * @param requestId The ID initially returned by requestRandomWords.
     * @param randomWords the VRF output expanded to the requested number of words.
     */
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] calldata randomWords
    ) internal override {
        uint256 d20Value = (randomWords[0] % 20) + 1;
        // s_results[requestId] = d20Value;

        // s_results[s_requestIdToRoller[requestId]] = d20Value;
        emit DiceLanded(requestId, d20Value);
    }
}
