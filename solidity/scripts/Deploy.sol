// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';

import {Config} from './Config.sol';
import {Script} from 'forge-std/Script.sol';

abstract contract DeployInternal is Script, Config {
  uint256 public constant FEE_BPS = 50;

  constructor() Config() {}

  function _deploy() internal {
    vm.startBroadcast();
    new CCIPxERC20Bridge(
      routers[block.chainid],
      links[block.chainid],
      xerc20s[block.chainid],
      FEE_BPS,
      lockboxes[block.chainid],
      erc20s[block.chainid]
    );
    vm.stopBroadcast();
  }
}

contract Deploy is DeployInternal {
  function run() external {
    _deploy();
  }
}
