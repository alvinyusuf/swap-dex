// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {TestToken} from "../src/TestToken.sol";

contract TestTokenTest is Test {
    TestToken public token;
    address public owner = address(this);
    address public user = address(0x123);

    function setUp() public {
        token = new TestToken("TestToken", "TTK", 1000);
    }

    function testFail_InitialSupply() public view {
        uint256 expectedSupply = 100 * 10 ** uint256(token.decimals());
        assertEq(token.totalSupply(), expectedSupply, "Innitial supply should be wrong 100 TTK");
    }

    function testInitialSupply() public view {
        uint256 expectedSupply = 1000 * 10 ** uint256(token.decimals());
        assertEq(token.totalSupply(), expectedSupply, "Innitial supply should be 1000 TTK");
        assertEq(token.balanceOf(owner), expectedSupply, "Owner should hold all initial supply");
    }

    function testFail_Mint() public {
        uint256 mintAmount = 500 * 10 ** uint256(token.decimals());
        vm.startPrank(user);
        vm.expectRevert("Ownable: caller is not the owner");
        token.mint(user, mintAmount);
        vm.stopPrank();
    }

    function testMint() public {
        uint256 mintAmount = 500 * 10 ** uint256(token.decimals());

        token.mint(user, mintAmount);
        assertEq(token.balanceOf(user), mintAmount, "User should receive minted tokens");
        assertEq(token.totalSupply(), 1500 * 10 ** uint256(token.decimals()), "Total supply should be 1500 TTK");
    }

    function testFail_BurnMoreThanBalance() public {
        uint256 burnAmount = 1500 * 10 ** uint256(token.decimals()); // Lebih besar dari saldo owner

        vm.expectRevert("ERC20: burn amount exceeds balance");
        token.burn(burnAmount);

        assertEq(
            token.balanceOf(owner),
            1000 * 10 ** uint256(token.decimals()),
            "Owner's balance should remain the same after failed burn"
        );
        assertEq(
            token.totalSupply(),
            1000 * 10 ** uint256(token.decimals()),
            "Total supply should remain the same after failed burn"
        );
    }

    function testBurn() public {
        uint256 burnAmount = 200 * 10 ** uint256(token.decimals());

        token.burn(burnAmount);
        assertEq(
            token.balanceOf(owner),
            (1000 - 200) * 10 ** uint256(token.decimals()),
            "Owner's balance should decrease after burn"
        );
        assertEq(
            token.totalSupply(),
            (1000 - 200) * 10 ** uint256(token.decimals()),
            "Total supply should decrease after burn"
        );
    }

    function testFail_BurnMoreThanUserBalance() public {
        uint256 transferAmount = 50 * 10 ** uint256(token.decimals());
        uint256 burnAmount = 100 * 10 ** uint256(token.decimals());

        token.transfer(user, transferAmount);

        vm.startPrank(user);
        vm.expectRevert("ERC20: burn amount exceeds balance");
        token.burn(burnAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user), transferAmount, "User's balance should remain the same after failed burn");
        assertEq(
            token.totalSupply(),
            1000 * 10 ** uint256(token.decimals()),
            "Total supply should remain the same after failed user burn"
        );
    }

    function testBurnOnlySelf() public {
        uint256 burnAmount = 100 * 10 ** uint256(token.decimals());

        token.transfer(user, burnAmount);

        vm.startPrank(user);
        token.burn(burnAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user), 0, "User should have zero balance after burning");
        assertEq(
            token.totalSupply(),
            (1000 - 100) * 10 ** uint256(token.decimals()),
            "Total supply should decrease after user's burn"
        );
    }

    function testFail_TransferMoreThanBalance() public {
        uint256 transferAmount = 1500 * 10 ** uint256(token.decimals());

        vm.expectRevert("ERC20: transfer amount exceeds balance");
        token.transfer(user, transferAmount);

        assertEq(
            token.balanceOf(owner),
            1000 * 10 ** uint256(token.decimals()),
            "Owner's balance should remain the same after failed transfer"
        );
        assertEq(token.balanceOf(user), 0, "User's balance should remain zero after failed transfer");
    }

    function testTransfer() public {
        uint256 transferAmount = 100 * 10 ** uint256(token.decimals());

        token.transfer(user, transferAmount);

        assertEq(
            token.balanceOf(owner),
            (1000 - 100) * 10 ** uint256(token.decimals()),
            "Owner's balance should decrease after transfer"
        );
        assertEq(token.balanceOf(user), transferAmount, "User's balance should increase after receiving transfer");
    }

    function testFail_TransferFromExceedsAllowance() public {
        uint256 allowanceAmount = 100 * 10 ** uint256(token.decimals());
        uint256 transferAmount = 200 * 10 ** uint256(token.decimals()); // Melebihi allowance

        token.approve(user, allowanceAmount);

        vm.startPrank(user);

        vm.expectRevert("ERC20: transfer amount exceeds allowance");
        token.transferFrom(owner, user, transferAmount);

        vm.stopPrank();
    }

    function testFail_ApproveWithoutOwnerPermission() public {
        uint256 allowanceAmount = 100 * 10 ** uint256(token.decimals());

        vm.startPrank(user);

        vm.expectRevert("Ownable: caller is not the owner");
        token.approve(user, allowanceAmount);

        vm.stopPrank();
    }

    function testApprove() public {
        uint256 allowanceAmount = 200 * 10 ** uint256(token.decimals());

        token.approve(user, allowanceAmount);

        assertEq(token.allowance(owner, user), allowanceAmount, "Allowance for user should match the approved amount");
    }
}
