// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import {UpgradeableWETH} from "src/UpgradeableWETH.sol";
import {useMinimumViableProxy} from "mini-proxy/Deployer.sol";

contract PoCTest is Test {
    address implementation; 
    UpgradeableWETH weth;
    address attacker = vm.addr(1);

    // MUST NOT use this address in `testCanGetIntoJessysHackerHouse`
    address __innocent = vm.addr(2);

    // MUST NOT change this function
    function setUp() public {
        implementation = address(new UpgradeableWETH());
        weth = UpgradeableWETH(payable(useMinimumViableProxy(implementation)));
        weth.initialize();

        vm.deal(__innocent, 1 ether);
        vm.prank(__innocent);
        weth.deposit{value: 1 ether}();
        assertEq(weth.balanceOf(__innocent), 1 ether);
    }

    // MUST NOT use cheatcodes
    function testCanGetIntoJessysHackerHouse() public {
        // -- EXPLOIT START --

        // -- EXPLOIT END --

        // MUST NOT remove
        _validate();
    }

    // MUST NOT change this function
    function _validate() internal {
        vm.expectRevert(bytes(""));
        vm.prank(__innocent);
        weth.withdraw(1 ether);
    }
}
