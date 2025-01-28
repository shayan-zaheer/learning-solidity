// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract Calculator {
    uint8 result = 0;

    function add(uint8 num) public{
        result += num;
    }

    function subtract(uint8 num) public {
        result -= num;
    }

    function get() public view returns (uint8){
        return result;
    }
}
