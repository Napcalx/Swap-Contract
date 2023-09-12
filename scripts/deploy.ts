import { ethers } from "hardhat";

async function main () {
  const [owner] = await ethers.getSigners();

  console.log("deploying contract:", owner.address);
  
  const TokenA = await ethers.deployContract("ERC20")
  const TokenB = await ethers.deployContract("ERC21")

  await TokenA.waitForDeployment()
  await TokenB.waitForDeployment()

  console.log("Contract Deployed at:", TokenA.target);
  console.log("COntract Deployed at:", TokenB.target);

};

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
