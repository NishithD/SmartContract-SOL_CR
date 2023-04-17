// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarRental {
    struct Driver {
        string name;
        uint256 age;
        string drivingLicense;
    }
    struct Car {
        string make;
        string model;
        uint256 year;
        string VIN;
        uint256 price;
        bool available;
    }

    mapping(string => Driver) public drivers;

    mapping(string => Car) public cars;

    event RentTransaction(string VIN, string driverName, uint256 rentalFee);

    function addDriver(
        string memory _name,
        uint256 _age,
        string memory _drivingLicense
    ) public {
        drivers[_drivingLicense] = Driver(_name, _age, _drivingLicense);
    }

    function addCar(
        string memory _make,
        string memory _model,
        uint256 _year,
        string memory _VIN,
        uint256 _price
    ) public {
        cars[_VIN] = Car(_make, _model, _year, _VIN, _price, true);
    }

    function rentCar(
        string memory _VIN,
        string memory _drivingLicense,
        uint256 _rentalFee
    ) public {
        require(
            bytes(drivers[_drivingLicense].name).length != 0,
            "Driver not registered."
        );
        require(bytes(cars[_VIN].make).length != 0, "Car does not exist.");
        require(cars[_VIN].available, "Car is not available.");
        cars[_VIN].available = false;
        emit RentTransaction(_VIN, drivers[_drivingLicense].name, _rentalFee);
    }

    function returnCar(string memory _VIN) public {
        require(bytes(cars[_VIN].make).length != 0, "Car does not exist.");
        require(!cars[_VIN].available, "Car is not rented.");
        cars[_VIN].available = true;
    }
}
