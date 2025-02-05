// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Twitter {
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    uint16 public MAX_TWEET_LENGTH = 280;

    mapping(address => Tweet[]) public tweets; // Each address stores an array of tweets

    function createTweet(string memory content) public {
        require(bytes(content).length <= MAX_TWEET_LENGTH, "Maximum length reached!"); // 1 byte is 1 character

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: content,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    function likeTweet(uint256 id, address author) external {
        require(tweets[author][id].id == id, "Tweet does not exist");
        tweets[author][id].likes++;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(uint256 id, address author) external {
        require(tweets[author][id].id == id, "Tweet does not exist!");
        require(tweets[author][id].likes > 0, "Tweet has no likes!");
        tweets[author][id].likes--;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i]; // Retrieves a specific tweet by index
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner]; // Retrieves all tweets of a user
    }
}
