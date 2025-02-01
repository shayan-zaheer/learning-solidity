// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract Mapping{
    mapping(address => uint8) public myMap;

    function setVal(address _addr, uint8 _val) public {
        myMap[_addr] = _val;
    }

    function getVal(address _addr) public view returns (uint8){
        return myMap[_addr];
    }

    function deleteVal(address _addr) public{
        delete myMap[_addr];
    }
}