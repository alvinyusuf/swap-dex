// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {FactoryToken} from "../src/FactoryToken.sol";

contract FactoryTokenScript is Script {
  FactoryToken public factory;

  function setUp() public {}

  function run() public {
    vm.startBroadcast();

    factory = new FactoryToken();

    vm.stopBroadcast();
  }
}
