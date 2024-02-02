// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';

abstract contract Config is Script {
  mapping(uint256 => address) public routers;
  mapping(uint32 => uint256) public forks;
  mapping(uint256 => address) public xerc20s;
  mapping(uint256 => address) public links;

  constructor() {
    routers[11_155_111] = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // sepolia
    routers[421_614] = 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165; // arb-sepolia

    links[11_155_111] = 0xCB3245E98233566B23a942652EA27049Ba8339C9;
    links[421_614] = 0x4ca12A7A1512C17E5cE3Ec5E29B11B0916B24328;

    xerc20s[11_155_111] = 0x78Ec54C9A377c03CA3A4fEd18684ff3c45A848d1;
    xerc20s[421_614] = 0xEd5d1B2310d5681C26905E112048A9EF0F129103;
  }
}
