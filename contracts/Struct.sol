// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TeslaRegistry {
    struct Tesla {
        string model;
        uint256 year;
        string color;
        uint256 mileage;
        string vin;  // Vehicle Identification Number
    }

    Tesla[] public teslas;  // Dynamic array to store Tesla cars

    function addTesla(
        string memory model, 
        uint256 year, 
        string memory color, 
        uint256 mileage, 
        string memory vin
    ) public {
        Tesla memory newTesla = Tesla({
            model: model,
            year: year,
            color: color,
            mileage: mileage,
            vin: vin
        });

        teslas.push(newTesla);
    }

    function getTesla(uint8 _index) public view returns (Tesla memory) {
        return teslas[_index];
    } 
}
