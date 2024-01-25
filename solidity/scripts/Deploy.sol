// SPDX-License-Identifier: MIT
pragma solidity =0.8.23;

import {CCIPxERC20Bridge} from '../contracts/CCIPxERC20Bridge.sol';
import {Greeter} from 'contracts/Greeter.sol';
import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'isolmate/interfaces/tokens/IERC20.sol';
import {ERC20} from 'isolmate/tokens/ERC20.sol';
import {XERC20} from 'xERC20/solidity/contracts/XERC20.sol';
import {XERC20Factory} from 'xERC20/solidity/contracts/XERC20Factory.sol';

contract TestLINK is ERC20 {
  constructor() ERC20('TestLINK', 'tLINK', 18) {
    _mint(msg.sender, 1_000_000_000);
  }
}

abstract contract Deploy is Script {
  mapping(uint32 => address) public routers;

  constructor() {
    routers[11_155_111] = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // sepolia
    routers[421_614] = 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165; // arb-sepolia
  }

  function _deployTestnet() internal {
    vm.createSelectFork(vm.rpcUrl('sepolia'));
    vm.startBroadcast();
    _deploy(11_155_111, true);
    vm.stopBroadcast();

    vm.createSelectFork(vm.rpcUrl('arb-sepolia'));
    vm.startBroadcast();
    _deploy(421_614, true);
    vm.stopBroadcast();
  }

  function _deploy(uint32 _chainId, bool _isTestnet) internal {
    address xerc20;
    IERC20 link;
    if (_isTestnet) {
      XERC20Factory factory = new XERC20Factory();
      xerc20 = factory.deployXERC20('TestXERC20', 'tXERC20', new uint256[](0), new uint256[](0), new address[](0));
      link = new TestLINK();
    }
    CCIPxERC20Bridge bridge = new CCIPxERC20Bridge(routers[_chainId], address(link), xerc20);
    XERC20(xerc20).setLimits(address(bridge), 1_000_000_000, 1_000_000_000);
  }
}

contract DeployTestnet is Deploy {
  function run() external {
    _deployTestnet();
  }
}

contract DeployMainnet is Deploy {
  function run() external {}
}
