// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract devUSDC is ERC20 {
    constructor(uint256 initialSupply) ERC20("U", "GLD") {
        _mint(msg.sender, initialSupply);
    }
}
