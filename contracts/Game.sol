// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Game {
    constructor() payable {}

    /***
        Randomly picks number between 0 and 2²⁵⁶–1
     */

    function pickACard() private view returns(uint) {

        uint pickedCard = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp)));
        return pickedCard;
    }

    // funtion that checks if player guessed the correct number and then sends 0.1 ETH
    function guess(uint _guess) public {
        uint _pickedCard = pickACard();// select a random number
        if(_guess == _pickedCard){
            (bool sent,) = msg.sender.call{value: 0.1 ether}("");
            require(sent, "Failed to send ether");
        }
    }

    // get the Balance of ETH in contract
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}