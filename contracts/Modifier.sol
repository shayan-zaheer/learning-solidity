// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    modifier checkPause() {
        require(paused == false, "The contract is paused!");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function transfer(address to, uint amount) public checkPause {
        require(balances[msg.sender] >= amount, "Insufficient balance!");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}