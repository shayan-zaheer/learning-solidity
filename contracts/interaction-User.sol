// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract User {
    struct Player {
        address playerAddress;
        string username;
        uint256 score;
    }

    mapping(address => Player) public players;

    function createUser(address userAddress, string memory username) external {
        require(players[userAddress].playerAddress == address(0), "User already exists!");

        Player memory newPlayer = Player({
            playerAddress: userAddress, 
            username: username,
            score: 0
        });

        players[userAddress] = newPlayer;
    }
}