// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthStaking {
    address public walletAddress;
    mapping(address => uint256) private _stakeHolders;
    mapping(address => uint48) private _stakeHoldersTimestamps;
    event Stake(address indexed _from, uint256 _value);
    uint256 public totalStakes;
    AggregatorV3Interface internal priceFeed;

    IERC20 private _token;

    constructor(IERC20 token) {
        _token = token;
        walletAddress = address(this);
        priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
        _stakeHolders[0x7deF3308aeF9eD686F0C27A60d9e85897b536A1D] = 5;
        _stakeHoldersTimestamps[
            0x7deF3308aeF9eD686F0C27A60d9e85897b536A1D
        ] = uint48(block.timestamp);
    }

    function stakeEth() public payable {
        require(msg.value > 5000000000000000001, "Should be at;east 5 Eths");
        _stakeHolders[msg.sender] = msg.value / 1 ether;
        _stakeHoldersTimestamps[msg.sender] = uint48(block.timestamp);
        emit Stake(msg.sender, msg.value);
        totalStakes += msg.value;
    }

    function RemoveStakeholder(address addr) public {
        delete _stakeHolders[addr];
    }

    // function stakeholderStakes(address addr)
    //     public
    //     view
    //     returns (uint256 stakes)
    // {
    //     return _stakeHolders[addr];
    // }

    function stakeholderTimestamp(address addr) public view returns (uint48) {
        return _stakeHoldersTimestamps[addr];
    }

    function getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    // function tranferTokens(address to, uint256 amount) external payable {
    //     address from = msg.sender;
    //     _token.transferFrom(from, to, amount);
    // }

    function allowanceOf(address addr) external view returns (uint256) {
        return _token.allowance(address(this), addr);
    }

    function stakesOf(address addr) external view returns (uint256 stakes) {
        return _stakeHolders[addr];
    }

    function myBalance() public view returns (uint256) {
        return _token.balanceOf(msg.sender);
    }

    function calculateRewards()
        public
        pure
        returns (
            /*address addr */
            uint256
        )
    {
        return 1;
    }

    function claimReward(address addr) public payable {}
}
