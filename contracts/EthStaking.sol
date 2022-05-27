// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthStaking {
    address public walletAddress;
    mapping(address => uint256) private _stakeHolders;
    AggregatorV3Interface internal priceFeed;
    ERC20 tokenERC20 = ERC20(0xB4f80771EF233466D0D5dae471F5cA45de12A9Bf);

    constructor() {
        walletAddress = msg.sender;
        priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
    }

    function logError(uint256 errorType)
        internal
        pure
        returns (string memory errorMsg_)
    {
        if (errorType == 1) {
            errorMsg_ = "Stakes must be more than 5 Eths.";
        }
        return errorMsg_;
    }

    function stakeEth() public payable {
        uint256 amount = msg.value;
        address payable addr = payable(walletAddress);
        addr.transfer(amount);
        _stakeHolders[msg.sender] = amount / 1 ether;
        //     address payable addr = payable(walletAddress);
        // if (value < 5000000000000000000) {
        //     address payable addr = payable(walletAddress);
        //     addr.transfer(value);
        //     _stakeHolders[msg.sender] = value / 1 ether;
        // } else {
        //     logError(1);
        // }
    }

    function stakeholderStakes(address addr)
        public
        view
        returns (uint256 stakes)
    {
        return _stakeHolders[addr];
    }

    function getLatestPrice() public view returns (uint256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        return uint256(price);
    }

    function myTokenInfo() public view returns (string memory name) {
        name = tokenERC20.name();
        return name;
    }

    function transfer() public {
        tokenERC20.transfer(0xe1A14F2B926F5E7e038e56DF9941Def9712aDd09, 1);
    }

    function calculateRewards(address addr) public view returns (uint256) {
        uint256 price = ((getLatestPrice() * _stakeHolders[addr]) * 5) / 100;
        return price;
    }
}
