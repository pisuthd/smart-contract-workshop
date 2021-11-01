const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Simple DEX", function () {

    it("Estimate 1 LINK -> WMATIC and 1 MATIC -> LINK", async () => {
        const Dex = await ethers.getContractFactory("SimpleDex");
        const dex = await Dex.deploy();
            
        await dex.deployed();

        const wmaticOutput = await dex.estimateLinkToMatic( ethers.utils.parseEther("1") )

        console.log("1 LINK = ", ethers.utils.formatEther(wmaticOutput) , " MATIC")

        expect(Number(wmaticOutput)).to.not.equal(0)

        const linkOutput = await dex.estimateWmaticToLink( ethers.utils.parseEther("1") )

        console.log("1 WMATIC = ", ethers.utils.formatEther(linkOutput) , " LINK")

        expect(Number(linkOutput)).to.not.equal(0)
    });


});
