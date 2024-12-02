// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {Router} from "../src/Router.sol";
import {TestToken} from "../src/TestToken.sol";
import {Factory} from "../src/Factory.sol";
import {LPToken} from "../src/LPToken.sol";
import {console} from "forge-std/console.sol";
import {IPair} from "../src/interfaces/IPair.sol";

contract RouterTest is Test {
    Router public router;
    TestToken public token0;
    TestToken public token1;
    Factory public factory;
    LPToken public lpToken;
    // address public pair;
    // uint256 public ratio;

    address public user1;

    function setUp() public {
        user1 = address(1);

        token0 = new TestToken("TokenA", "TTA", 500000000);
        token1 = new TestToken("TokenB", "TTB", 500000000);

        token0.transfer(user1, 1000000 * 10 ** 18);
        token1.transfer(user1, 1000000 * 10 ** 18);

        factory = new Factory();
        lpToken = new LPToken(address(factory));
        router = new Router(address(factory));

        factory.setLPToken(address(lpToken));
    }

    function testAddLiquidity() public {
        vm.startPrank(user1);

        uint256 amount0 = 1000;
        uint256 amount1 = 2;

        token0.approve(address(router), amount0);
        token1.approve(address(router), amount1);

        uint256 liquidity = router.addLiquidity(address(token0), address(token1), amount0, amount1);

        console.log("Liquidity added: %d", liquidity);

        uint256 lpBalance = lpToken.balanceOf(user1);
        lpToken.approve(address(router), lpBalance);

        uint256 token0BalanceBefore = token0.balanceOf(user1);
        uint256 token1BalanceBefore = token1.balanceOf(user1);

        console.log("Token0 balance before: %d", token0BalanceBefore);
        console.log("Token1 balance before: %d", token1BalanceBefore);
    }

    // function testRemoveLiquidity() public {
    //     vm.startPrank(user1);

    //     uint256 amount0 = 1000;
    //     uint256 amount1 = 2;

    //     token0.approve(address(router), amount0);
    //     token1.approve(address(router), amount1);

    //     uint256 liquidity = router.addLiquidity(
    //         address(token0),
    //         address(token1),
    //         amount0,
    //         amount1
    //     );

    //     console.log("Liquidity added: %d", liquidity);

    //     uint256 lpBalance = lpToken.balanceOf(user1);
    //     lpToken.approve(address(router), lpBalance);

    //     uint256 token0BalanceBefore = token0.balanceOf(user1);
    //     uint256 token1BalanceBefore = token1.balanceOf(user1);

    //     console.log("Token0 balance before: %d", token0BalanceBefore);
    //     console.log("Token1 balance before: %d", token1BalanceBefore);

    //     router.removeLiquidity(
    //         address(token0),
    //         address(token1),
    //         lpBalance
    //     );

    //     console.log("Token0 balance before: %d", token0.balanceOf(user1));
    //     console.log("Token0 balance before: %d", token1.balanceOf(user1));

    //     assert(token0.balanceOf(user1) > token0BalanceBefore);
    //     assert(token1.balanceOf(user1) > token1BalanceBefore);

    //     vm.stopPrank();
    // }

    // function testSwap() public {
    //     vm.startPrank(user1);

    //     uint256 amount0 = 100000;
    //     uint256 amount1 = 90000;
    //     uint256 amountSwap = 1000;

    //     token0.approve(address(router), amount0);
    //     token1.approve(address(router), amount1);

    //     uint256 liquidity = router.addLiquidity(
    //         address(token0),
    //         address(token1),
    //         amount0,
    //         amount1
    //     );

    //     console.log("Liquidity added: %d", liquidity);

    //     address pair = factory.getPair(address(token0), address(token1));
    //     console.log("Token0 amount0: %d", IPair(pair).reserve0());
    //     console.log("Token0 amount1: %d", IPair(pair).reserve1());

    //     uint256 balanceBefore = token1.balanceOf(user1);

    //     router.swapExactTokensForTokens(
    //         address(token0),
    //         address(token1),
    //         amountSwap,
    //         9,
    //         block.timestamp + 1 minutes
    //     );

    //     uint256 balanceAfter = token1.balanceOf(user1);
    //     assert(balanceAfter > balanceBefore);

    //     vm.stopPrank();
    // }
}
