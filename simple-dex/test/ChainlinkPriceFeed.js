const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Chainlink Price Feed", function () {

    it("Get $LINK price", async () => {
        const PriceFeed = await ethers.getContractFactory("ChainlinkPriceFeed");
        const priceFeed = await PriceFeed.deploy();
            
        await priceFeed.deployed();

        const output = await priceFeed.getCurrentPrice()

        console.log("OUTPUT : ", (Number(output) / 100000000)) // 8 decimal places

        expect(Number(output)).to.not.equal(0)
    });

});
