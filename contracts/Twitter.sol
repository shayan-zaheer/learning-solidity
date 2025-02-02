// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Twitter {
    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets; // Each address stores an array of tweets

    function createTweet(string memory content) public {
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: content,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _owner, uint _i) public view returns (Tweet memory) {
        return tweets[_owner][_i]; // Retrieves a specific tweet by index
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner]; // Retrieves all tweets of a user
    }
}
