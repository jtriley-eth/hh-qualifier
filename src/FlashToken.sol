// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "oz/token/ERC20/extensions/ERC20FlashMint.sol";

contract FlashToken is ERC20FlashMint {
    constructor() ERC20("Flash Token", "FLT") {
        _mint(msg.sender, 10 ether);
    }

    function _flashFee(address, uint256 amount) internal pure override returns (uint256) {
        return amount * 3 / 100;
    }
}
