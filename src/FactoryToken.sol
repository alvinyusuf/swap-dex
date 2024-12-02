// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {TestToken} from "./TestToken.sol";

contract FactoryToken {
  event TokenCreated(address indexed token);

  function createToken(string calldata name, string calldata symbol, uint256 initialSupply) external returns (address) {
    TestToken token = new TestToken(name, symbol, initialSupply);
    emit TokenCreated(address(token));
    return address(token);
  }
}