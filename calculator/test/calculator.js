const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Calculator", function () {

    it("2+3 = 5", async () => {
        const Calculator = await ethers.getContractFactory("Calculator");
        const calculator = await Calculator.deploy();
            
        await calculator.deployed();

        // set A value
        await calculator.setA(2)

        // set B value
        await calculator.setB(3)


        // 3+2 = 5

        const result = await calculator.combineAB()

        expect(result).to.equal(5)
    });

    it("10-7 = 3", async () => {
        const Calculator = await ethers.getContractFactory("Calculator");
        const calculator = await Calculator.deploy();
            
        await calculator.deployed();

        // set A value
        await calculator.setA(10)

        // set B value
        await calculator.setB(7)

        // 10-7 = 3
        const result = await calculator.subtractAB()

        expect(result).to.equal(3)
    });
});
