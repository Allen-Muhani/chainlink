// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { VRFD20 } from "../src/VRFD20.sol";

/**
 * @title VRFD roll dice.
 * @author Allen Muhani.
 * @notice Picks the most recently VRFD20 deployed on the current chain and runs its rollDice function.
 * @notice To see the events and/find out if the fulfillRandomWords function was called emmiting the
 *  DiceLanded eveent; check the smart contrct on etherscan events.
 */
contract VRFD20RollDice is Script {
    function rollDice(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        VRFD20(mostRecentlyDeploy).rollDice(address(this));
        vm.stopBroadcast();

        console.log("Caller/Roller address ", address(this));
    }

    function run() external {
        address mostRcentlyDeployed =
            DevOpsTools.get_most_recent_deployment("VRFD20", block.chainid);
        console.log("Deployed contract address", mostRcentlyDeployed);
        rollDice(mostRcentlyDeployed);
    }
}
