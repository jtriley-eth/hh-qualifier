// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

interface IERC1822 {
    function proxiableUUID() external view returns (bytes32);
}
