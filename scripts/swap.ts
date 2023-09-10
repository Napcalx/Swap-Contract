import { ethers } from "hardhat";

async function main() {
    const Swap = await ethers.deployContract("Swap", [
        '0xde79380FBd39e08150adAA5C6c9dE3146f53029e',
        '0xbFD3c8A956AFB7a9754C951D03C9aDdA7EC5d638'
    ]);

    Swap.waitForDeployment();

    console.log(Swap.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });