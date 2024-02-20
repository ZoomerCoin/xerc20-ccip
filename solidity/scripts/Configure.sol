// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';

import {Config} from './Config.sol';
import {Script} from 'forge-std/Script.sol';
import {XERC20} from 'xERC20/solidity/contracts/XERC20.sol';

abstract contract Configure is Script, Config {
  uint256 public constant MINT_BURN_LIMIT = 1_000_000_000 ether;

  constructor() Config() {}

  function _configure(uint32[] memory _otherChainIds) internal {
    vm.startBroadcast();
    _configureBridge(_otherChainIds);
    vm.stopBroadcast();
  }

  function _configureBridge(uint32[] memory _otherChainIds) internal {
    CCIPxERC20Bridge bridge = CCIPxERC20Bridge(bridges[block.chainid]);
    require(address(bridge) != address(0), 'bridge not deployed');
    if (
      XERC20(xerc20s[block.chainid]).mintingCurrentLimitOf(address(bridge)) != MINT_BURN_LIMIT
        || XERC20(xerc20s[block.chainid]).burningCurrentLimitOf(address(bridge)) != MINT_BURN_LIMIT
    ) {
      XERC20(xerc20s[block.chainid]).setLimits(address(bridge), MINT_BURN_LIMIT, MINT_BURN_LIMIT);
    }
    for (uint256 i = 0; i < _otherChainIds.length; i++) {
      if (
        bridge.bridgesByChain(bridge.chainIdToChainSelector(_otherChainIds[i])) == address(bridges[_otherChainIds[i]])
      ) {
        continue;
      }
      bridge.addBridgeForChain(bridge.chainIdToChainSelector(_otherChainIds[i]), address(bridges[_otherChainIds[i]]));
    }
  }
}

contract ConfigureSepolia is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 421_614;
    _configure(_otherChainIds);
  }
}

contract ConfigureArbSepolia is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](1);
    _otherChainIds[0] = 11_155_111;
    _configure(_otherChainIds);
  }
}

contract ConfigureMainnet is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 10;
    _otherChainIds[2] = 42_161;
    _otherChainIds[3] = 137;
    _otherChainIds[4] = 56;
    _configure(_otherChainIds);
  }
}

contract ConfigureBase is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 10;
    _otherChainIds[1] = 42_161;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _otherChainIds[4] = 1;
    _configure(_otherChainIds);
  }
}

contract ConfigureArbitrum is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 10;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _otherChainIds[4] = 1;
    _configure(_otherChainIds);
  }
}

contract ConfigureOptimism is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 42_161;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _otherChainIds[4] = 1;
    _configure(_otherChainIds);
  }
}

contract ConfigureBsc is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 137;
    _otherChainIds[2] = 10;
    _otherChainIds[3] = 42_161;
    _otherChainIds[4] = 1;
    _configure(_otherChainIds);
  }
}

contract ConfigurePolygon is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](5);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 10;
    _otherChainIds[2] = 42_161;
    _otherChainIds[3] = 56;
    _otherChainIds[4] = 1;
    _configure(_otherChainIds);
  }
}
