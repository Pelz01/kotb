// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingOfTheBlock {
    address public owner;
    uint256 public currentPrice;
    string public currentMessage;
    address public currentKing;

    event ThroneClaimed(address indexed user, uint256 amount, string note);

    constructor() {
        owner = msg.sender;
        currentPrice = 0.001 ether;
        currentMessage = "The Block is Empty";
    }

    function claimThrone(string memory _message) external payable {
        require(msg.value >= (currentPrice * 105) / 100, "Bid must be 5% higher");
        
        uint256 previousPrice = currentPrice;
        currentPrice = msg.value;
        currentMessage = _message;
        currentKing = msg.sender;

        emit ThroneClaimed(msg.sender, msg.value, _message);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
