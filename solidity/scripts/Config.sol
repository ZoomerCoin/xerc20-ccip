// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';

abstract contract Config is Script {
  mapping(uint256 => address) public routers;
  mapping(uint32 => uint256) public forks;
  mapping(uint256 => address) public xerc20s;
  mapping(uint256 => address) public links;
  mapping(uint256 => address) public lockboxes;
  mapping(uint256 => address) public erc20s;

  constructor() {
    // sepolia
    routers[11_155_111] = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    links[11_155_111] = 0xCB3245E98233566B23a942652EA27049Ba8339C9;
    xerc20s[11_155_111] = 0x78Ec54C9A377c03CA3A4fEd18684ff3c45A848d1;

    // arb-sepolia
    routers[421_614] = 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165;
    links[421_614] = 0x4ca12A7A1512C17E5cE3Ec5E29B11B0916B24328;
    xerc20s[421_614] = 0xEd5d1B2310d5681C26905E112048A9EF0F129103;

    // mainnet
    routers[1] = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;
    links[1] = 0x514910771AF9Ca656af840dff83E8264EcF986CA;
    xerc20s[1] = 0x425F81E2fe53256B9a7AEA91949dA2210bd049bE;
    lockboxes[1] = 0xB3bC2AaabB4C27890dBB491550eac3843A946625;
    erc20s[1] = 0x0D505C03d30e65f6e9b4Ef88855a47a89e4b7676;

    // optimism
    routers[10] = 0x3206695CaE29952f4b0c22a169725a865bc8Ce0f;
    links[10] = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;
    xerc20s[10] = 0xB962150760F9A3bB00e3E9Cf48297EE20AdA4A33;

    // arbitrum
    routers[42_161] = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;
    links[42_161] = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
    xerc20s[42_161] = 0xB962150760F9A3bB00e3E9Cf48297EE20AdA4A33;

    // polygon
    routers[137] = 0x849c5ED5a80F5B408Dd4969b78c2C8fdf0565Bfe;
    links[137] = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;
    xerc20s[137] = 0xB962150760F9A3bB00e3E9Cf48297EE20AdA4A33;

    // avalanche
    routers[43_114] = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
    links[43_114] = 0x5947BB275c521040051D82396192181b413227A3;

    // bnb
    routers[56] = 0x34B03Cb9086d7D758AC55af71584F81A598759FE;
    links[56] = 0x404460C6A5EdE2D891e8297795264fDe62ADBB75;
    xerc20s[56] = 0xB962150760F9A3bB00e3E9Cf48297EE20AdA4A33;

    // base
    routers[8453] = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;
    links[8453] = 0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196;
    xerc20s[8453] = 0xD1dB4851bcF5B41442cAA32025Ce0Afe6B8EabC2;
  }
}
