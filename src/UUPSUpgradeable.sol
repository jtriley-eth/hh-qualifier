// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "src/interfaces/IERC1822.sol";
import "src/OwnableUpgradeable.sol";

abstract contract UUPSUpgradeable is IERC1822, OwnableUpgradeable {
    error NotUUPS();
    error UnsupportedProxy();

    bytes32 constant public proxiableUUID =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function implementation() external view returns (address impl) {
        assembly { impl := sload(proxiableUUID) }
    }

    function upgradeTo(address newImplementation) external {
        if (owner != msg.sender && owner != address(0)) revert Unauthorized();
        try IERC1822(newImplementation).proxiableUUID() returns (bytes32 pid) {
            if (pid != proxiableUUID) revert UnsupportedProxy();
            assembly { sstore(proxiableUUID, newImplementation) }
        } catch {
            revert NotUUPS();
        }
    }

    function upgradeToAndCall(address newImplementation, bytes memory data)
        external
        returns (bool success, bytes memory returndata)
    {
        if (owner != msg.sender && owner != address(0)) revert Unauthorized();
        try IERC1822(newImplementation).proxiableUUID() returns (bytes32 pid) {
            if (pid != proxiableUUID) revert UnsupportedProxy();
        } catch {
            revert NotUUPS();
        }
        assembly { sstore(proxiableUUID, newImplementation) }
        (success, returndata) = newImplementation.delegatecall(data);
    }
}
