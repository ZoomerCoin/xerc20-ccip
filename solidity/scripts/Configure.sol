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

abstract contract Configure is Script, Config {
  mapping(uint256 => CCIPxERC20Bridge) public bridges;

  constructor() Config() {
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
