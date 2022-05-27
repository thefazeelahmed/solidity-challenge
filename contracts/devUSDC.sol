// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract devUSDC is ERC20 {
    constructor() ERC20("USDC", "GLD") {
        _mint(msg.sender, 10000);
    }
}
