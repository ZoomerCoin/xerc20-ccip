// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';

import {Config} from './Config.sol';
import {Script} from 'forge-std/Script.sol';

abstract contract CleanUp is Script, Config {
  mapping(uint256 => CCIPxERC20Bridge) public cleanup;

  constructor() Config() {
    cleanup[1] = CCIPxERC20Bridge(payable(0x14588B66685326280396e0799fA292127B9d1465)); // mainnet
  }

  function _cleanup(uint32[] memory _otherChainIds) internal {
    vm.startBroadcast();
    _cleanupBridge(_otherChainIds);
    vm.stopBroadcast();
  }

  function _cleanupBridge(uint32[] memory _otherChainIds) internal {
    CCIPxERC20Bridge bridge = CCIPxERC20Bridge(bridges[block.chainid]);
    require(address(bridge) != address(0), 'bridge not deployed');
    for (uint256 i = 0; i < _otherChainIds.length; i++) {
      if (bridge.bridgesByChain(bridge.chainIdToChainSelector(_otherChainIds[i])) == address(0)) {
        continue;
      }
      bridge.addBridgeForChain(bridge.chainIdToChainSelector(_otherChainIds[i]), address(0));
    }
  }
}

contract CleanUpSepolia is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 421_614;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpArbSepolia is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 11_155_111;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpMainnet is CleanUp {
  function run() external {}
}

contract CleanUpBase is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 1;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpArbitrum is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 1;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpOptimism is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 1;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpBsc is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 1;
    _cleanup(_otherChainIds);
  }
}

contract CleanUpPolygon is CleanUp {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 1;
    _cleanup(_otherChainIds);
  }
}
