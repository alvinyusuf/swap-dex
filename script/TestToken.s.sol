// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {TestToken} from "../src/TestToken.sol";

contract TestTokenScript is Script {
  TestToken public token;

  function setUp() public {}

  function run() public {
    vm.startBroadcast();

    token = new TestToken("TestTokenA", "TTA", 1000);

    vm.stopBroadcast();
  }
}
