// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {UUPSUpgradeable} from "oz-up/proxy/utils/UUPSUpgradeable.sol";
import {ERC20Upgradeable} from "oz-up/token/ERC20/ERC20Upgradeable.sol";
import {OwnableUpgradeable} from "oz-up/access/OwnableUpgradeable.sol";

/// @title Totally Secure Upgradeable WETH
/// @author jtriley.eth
/// @notice Totally secure, no vulns here, nope.
contract UpgradeableWETH is UUPSUpgradeable, ERC20Upgradeable, OwnableUpgradeable {
    /// @notice Logged on deposit
    /// @param depositooor Depositing account
    /// @param amount Amount deposited
    event Deposit(address indexed depositooor, uint256 amount);

    /// @notice Logged on withdrawal
    /// @param withdrawooor Withdrawing account
    /// @param amount Amount withdrawn
    event Withdrawal(address indexed withdrawooor, uint256 amount);

    /// @dev Initializes ERC20 and Ownable
    function initialize() external initializer {
        __Ownable_init();
        __ERC20_init("Upgradeable WETH", "UWETH");
    }

    /// @notice Withdraw ether
    /// @param amount Amount to withdraw
    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    /// @notice Deposit ether
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Ether transfer without calldata counts as deposit
    receive() external payable {
        deposit();
    }

    // authorizes upgrade
    function _authorizeUpgrade(address) internal view override {
        // must either be owner OR owner must not be set
        require(owner() == _msgSender() || owner() == address(0), "unauthorized");
    }
}
