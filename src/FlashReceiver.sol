// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "oz/interfaces/IERC3156FlashBorrower.sol";

bytes32 constant ON_FLASH_LOAN = 0x439148f0bbc682ca079e46d6e2c2f0c1e3b820f1a291b069d8882abf8cf18dd9;

contract FlashReceiver is IERC3156FlashBorrower {
    address owner;
    address target;
    address flashToken;

    constructor(address _target, address _flashToken) {
        owner = msg.sender;
        target = _target;
        flashToken = _flashToken;
        (bool success, ) = flashToken.call(
            abi.encodeWithSelector(0x095ea7b3, flashToken, type(uint256).max)
        );
        require(success);
    }

    function setTarget(address newTarget) external {
        require(owner == msg.sender);
        target = newTarget;
    }

    function onFlashLoan(
        address,
        address,
        uint256,
        uint256,
        bytes memory data
    ) external returns (bytes32) {
        assembly {
            if or(
                iszero(
                    delegatecall(
                        gas(),
                        sload(target.slot),
                        data,
                        mload(data),
                        returndatasize(),
                        returndatasize()
                    )
                ),
                iszero(eq(caller(), sload(flashToken.slot)))
            ) { revert(0x00, 0x00) }
            mstore(0x00, 0x439148f0bbc682ca079e46d6e2c2f0c1e3b820f1a291b069d8882abf8cf18dd9)
            return(0x00, 0x20)
        }
    }

    fallback() external {
        // -- snip --
    }
}
