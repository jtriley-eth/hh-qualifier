// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

abstract contract OwnableUpgradeable {
    error Unauthorized();

    address public owner;

    function __init() internal {
        owner = msg.sender;
    }
}
