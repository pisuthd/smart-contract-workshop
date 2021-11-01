// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {

    uint256 public A = 0;
    uint256 public B = 0;

    function setA(uint256 value) public {
        A = value;
    }

    function setB(uint256 value) public {
        B = value;
    }

    function combineAB() public view returns (uint256) {
        return A+B;
    }

    function subtractAB() public view returns (uint256) {
        return A-B;
    }

}

