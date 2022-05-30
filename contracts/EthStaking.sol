// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthStaking {
    address public walletAddress;
    mapping(address => uint256) private _stakeHolders;
    mapping(address => uint48) private _stakeHoldersTimestamps;

    AggregatorV3Interface internal priceFeed;
    ERC20 tokenERC20 = ERC20(0xd9145CCE52D386f254917e481eB44e9943F39138);

    constructor() {
        walletAddress = address(this);
        priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
        _stakeHolders[0x7deF3308aeF9eD686F0C27A60d9e85897b536A1D] = 5;
        _stakeHoldersTimestamps[
            0x7deF3308aeF9eD686F0C27A60d9e85897b536A1D
        ] = uint48(block.timestamp);
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
        // _stakeHolders[msg.sender] = amount / 1 ether;
        // //     address payable addr = payable(walletAddress);
        // // if (value < 5000000000000000000) {
        // //     address payable addr = payable(walletAddress);
        // //     addr.transfer(value);
        // //     _stakeHolders[msg.sender] = value / 1 ether;
        // // } else {
        // //     logError(1);
        // // }
        // return getLatestPrice();
    }

    function stakeholderStakes(address addr)
        public
        view
        returns (uint256 stakes)
    {
        return _stakeHolders[addr];
    }

    function stakeholderTimestamp(address addr) public view returns (uint48) {
        return _stakeHoldersTimestamps[addr];
    }

    function getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();

        return price;
    }

    function myTokenInfo() public view returns (string memory name) {
        name = tokenERC20.name();
        return name;
    }

    function transfer() public payable {
        console.log(address(this));
        console.log(tokenERC20.balanceOf(address(this)));
        console.log(
            tokenERC20.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)
        );
        tokenERC20.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 200);
        tokenERC20.transferFrom(
            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
            100
        );
        console.log(
            tokenERC20.balanceOf(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db)
        );
        console.log(tokenERC20.balanceOf(address(this)));
    }

    // function calculateRewards(address addr) public view returns (uint) {

    // }

    // function claimReward(address addr) public payable {
    //     tokenERC20.transfer(0xe1A14F2B926F5E7e038e56DF9941Def9712aDd09, 30000);
    // }
}
