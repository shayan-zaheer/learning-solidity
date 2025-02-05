// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }

    function getProfile(address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable {
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    IProfile public profileContract;

    constructor(address _profileContractAddress) Ownable(msg.sender){
        profileContract = IProfile(_profileContractAddress);
    }

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    modifier onlyRegistered() {
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0, "User not registered!");
        _;
    }

    uint16 public MAX_TWEET_LENGTH = 280;

    mapping(address => Tweet[]) public tweets;

    function createTweet(string memory content) public onlyRegistered {
        require(bytes(content).length <= MAX_TWEET_LENGTH, "Maximum length reached!");

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

    function likeTweet(uint256 id, address author) external onlyRegistered {
        require(id < tweets[author].length, "Tweet does not exist");
        tweets[author][id].likes++;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(uint256 id, address author) external onlyRegistered {
        require(id < tweets[author].length, "Tweet does not exist");
        require(tweets[author][id].likes > 0, "Tweet has no likes");
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTotalLikes(address _user) public view returns (uint256) {
        uint256 totalLikes = 0;
        for (uint256 i = 0; i < tweets[_user].length; i++) {
            totalLikes += tweets[_user][i].likes;
        }
        return totalLikes;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTweet(uint256 _i) public view returns (Tweet memory) {
        require(_i < tweets[msg.sender].length, "Invalid tweet index");
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
