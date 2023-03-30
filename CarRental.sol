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

    /**
     * @dev Adds a new driver to the system.
     *
     * @param _name Name of the driver
     * @param _age Age of the driver
     * @param _drivingLicense Driving license of the driver
     */
    function addDriver(
        string memory _name,
        uint256 _age,
        string memory _drivingLicense
    ) public {
        drivers[_drivingLicense] = Driver(_name, _age, _drivingLicense);
    }

    /**
     * @dev Adds a new car to the system.
     *
     * @param _make Make of the car
     * @param _model Model of the car
     * @param _year Year of the car
     * @param _VIN Vehicle Identification Number of the car
     * @param _price Price of the car
     */
    function addCar(
        string memory _make,
        string memory _model,
        uint256 _year,
        string memory _VIN,
        uint256 _price
    ) public {
        cars[_VIN] = Car(_make, _model, _year, _VIN, _price, true);
    }

    /**
     * @dev Rents a car for a specific rental fee.
     *
     * @param _VIN Vehicle Identification Number of the car
     * @param _drivingLicense Driving license of the driver
     * @param _rentalFee Rental fee for the car
     */
    function rentCar(
        string memory _VIN,
        string memory _drivingLicense,
        uint256 _rentalFee
    ) public {
        require(
            bytes(drivers[_drivingLicense].name).length != 0,
            "Driver not registered."
        );
        require(cars[_VIN].available, "Car is not available.");
        cars[_VIN].available = false;
        emit RentTransaction(_VIN, drivers[_drivingLicense].name, _rentalFee);
    }

    /**
     * @dev Returns a car that was previously rented.
     *
     * @param _VIN Vehicle Identification Number of the car
     */
    function returnCar(string memory _VIN) public {
        require(!cars[_VIN].available, "Car is not rented.");
        cars[_VIN].available = true;
    }
}
