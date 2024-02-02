// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';

import {Config} from './Config.sol';
import {Greeter} from 'contracts/Greeter.sol';
import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'isolmate/interfaces/tokens/IERC20.sol';
import {ERC20} from 'isolmate/tokens/ERC20.sol';
import {XERC20} from 'xERC20/solidity/contracts/XERC20.sol';
import {XERC20Factory} from 'xERC20/solidity/contracts/XERC20Factory.sol';

contract TestLINK is ERC20 {
  constructor() ERC20('TestLINK', 'tLINK', 18) {
    _mint(msg.sender, 1_000_000_000 ether);
  }
}

abstract contract _Deploy is Script, Config {
  constructor() Config() {}

  function _deploy() internal {
    vm.startBroadcast();
    CCIPxERC20Bridge _bridge =
      new CCIPxERC20Bridge(routers[block.chainid], links[block.chainid], xerc20s[block.chainid]);
    vm.stopBroadcast();
  }
}

contract Deploy is _Deploy {
  function run() external {
    _deploy();
  }
}
