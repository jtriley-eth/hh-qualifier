// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/FlashToken.sol";
import "src/FlashReceiver.sol";

contract PoCTest is Test {
    address __innocent = vm.addr(1);
    address attacker = vm.addr(2);
    FlashToken token;
    FlashReceiver receiver;
    uint256 initBalance = 10 ether;

    // MUST NOT change this function
    function setUp() public {
        vm.startPrank(__innocent);
        token = new FlashToken();
        receiver = new FlashReceiver(address(0), address(token));
        token.transfer(address(receiver), token.balanceOf(__innocent));
        vm.stopPrank();
    }

    // MUST NOT use cheatcodes
    function testCanGetIntoJessysHackerHouse() public {
        vm.startPrank(attacker);

        // -- EXPLOIT START --

        // -- EXPLOIT END --
        vm.stopPrank();

        // MUST NOT remove
        _validate();
    }

    // MUST NOT change this function
    function _validate() internal {
        assertTrue(token.balanceOf(address(receiver)) < initBalance);
    }
}
