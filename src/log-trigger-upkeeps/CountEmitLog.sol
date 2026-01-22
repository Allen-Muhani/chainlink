// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CountEmitLog {
    event WantsToCount(address indexed msgSender);

    constructor() { }

    function emitCountLog() external {
        emit WantsToCount(msg.sender);
    }
}

