// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "src/ERC20Upgradeable.sol";
import "src/UUPSUpgradeable.sol";
import "src/Initializeable.sol";

/// @title Totally Secure Upgradeable WETH
/// @author jtriley.eth
/// @notice Totally secure, no vulns here, nope.
contract UpgradeableWETH is UUPSUpgradeable, ERC20Upgradeable, Initializeable {
    event Deposit(address indexed depositooor, uint256 value);
    event Withdrawal(address indexed withdrawooor, uint256 value);

    function initialize() external initializer {
        ERC20Upgradeable.__init("Upgradeable WETH", "UWETH", 18);
        OwnableUpgradeable.__init();
    }

    function withdraw(uint256 value) external {
        balanceOf[msg.sender] -= value;
        payable(msg.sender).transfer(value);
        emit Transfer(msg.sender, address(0), value);
        emit Withdrawal(msg.sender, value);
    }

    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    receive() external payable {
        deposit();
    }
}
