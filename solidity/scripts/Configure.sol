// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';

import {Config} from './Config.sol';
import {Script} from 'forge-std/Script.sol';
import {XERC20} from 'xERC20/solidity/contracts/XERC20.sol';

abstract contract Configure is Script, Config {
  mapping(uint256 => CCIPxERC20Bridge) public bridges;

  constructor() Config() {
    bridges[10] = CCIPxERC20Bridge(payable(0x0337c7b958aC69A9e35b1Be47D96b8e058f9222a)); // optimism
    bridges[56] = CCIPxERC20Bridge(payable(0x840854c007c1E5F64074350beECa088F8a8e48BF)); // bsc
    bridges[137] = CCIPxERC20Bridge(payable(0xB2e04651aC165CB6D2b8B0442ab25231DEf15b51)); // polygon
    bridges[8453] = CCIPxERC20Bridge(payable(0x083178fBB5d6dd6521fe778BcfC32BF898678fAe)); // base
    bridges[42_161] = CCIPxERC20Bridge(payable(0x0337c7b958aC69A9e35b1Be47D96b8e058f9222a)); // arbitrum

    bridges[11_155_111] = CCIPxERC20Bridge(payable(0x13ceCe7E3389d4BE38223AB2F539870F8a7324B8)); // sepolia
    bridges[421_614] = CCIPxERC20Bridge(payable(0x379A9152c02449b1AE738BDd2E4E207fC2b19Cc9)); // arb-sepolia
  }

  function _configure(uint32[] memory _otherChainIds) internal {
    vm.startBroadcast();
    _configureBridge(_otherChainIds);
    vm.stopBroadcast();
  }

  function _configureBridge(uint32[] memory _otherChainIds) internal {
    CCIPxERC20Bridge bridge = CCIPxERC20Bridge(bridges[block.chainid]);
    XERC20(xerc20s[block.chainid]).setLimits(address(bridge), 1_000_000_000 ether, 1_000_000_000 ether);
    require(address(bridge) != address(0), 'bridge not deployed');
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

contract ConfigureBase is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](4);
    _otherChainIds[0] = 10;
    _otherChainIds[1] = 42_161;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _configure(_otherChainIds);
  }
}

contract ConfigureArbitrum is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](4);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 10;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _configure(_otherChainIds);
  }
}

contract ConfigureOptimism is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](4);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 42_161;
    _otherChainIds[2] = 137;
    _otherChainIds[3] = 56;
    _configure(_otherChainIds);
  }
}

contract ConfigureBsc is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](4);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 137;
    _otherChainIds[2] = 10;
    _otherChainIds[3] = 42_161;
    _configure(_otherChainIds);
  }
}

contract ConfigurePolygon is Configure {
  function run() external {
    uint32[] memory _otherChainIds = new uint32[](4);
    _otherChainIds[0] = 8453;
    _otherChainIds[1] = 10;
    _otherChainIds[2] = 42_161;
    _otherChainIds[3] = 56;
    _configure(_otherChainIds);
  }
}
