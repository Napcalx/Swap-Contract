import { ethers, network } from "hardhat";

async function main () {
    const uniswapAddr = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
    const UNI = '0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984';
    const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
    const amountUNIDesired = await ethers.parseEther("8");
    const amountDAIDesired = await ethers.parseEther("9");
    const amountAMin = await ethers.parseEther("0");
    const amountBMin = await ethers.parseEther("0");
    const to = "0x20bB82F2Db6FF52b42c60cE79cDE4C7094Ce133F";
    const Signer = "0x20bB82F2Db6FF52b42c60cE79cDE4C7094Ce133F"
    const currentTimestampInSeconds = Math.round(Date.now() / 1000)
    const deadline = currentTimestampInSeconds + 86400;

    const Uniswap = await ethers.getContractAt("IUniswap", uniswapAddr);
    const UniContract = await ethers.getContractAt("IERC20", UNI);
    const daiContract = await ethers.getContractAt("IERC20", DAI);
    const UniSigner = await ethers.getImpersonatedSigner(Signer);


    // set balance of signer
    await network.provider.send('hardhat_setBalance', [
        Signer,
        '0x91A76D5E7CC6F7DEE00000',
    ])

    await UniContract.connect(UniSigner).
        approve(uniswapAddr, amountAMin);
    console.log(await parseInt(String(await UniContract.balanceOf(to))));

    await daiContract.connect(UniSigner).
        approve(uniswapAddr, amountBMin);
    console.log(await parseInt(String(await daiContract.balanceOf(to))));

    await Uniswap
        .connect(UniSigner)
        .addLiquidity(UNI, DAI, amountUNIDesired, amountDAIDesired, amountAMin, amountBMin, to, deadline)
    console.log(await parseInt(String(await daiContract.balanceOf(to))))
    console.log(await UniContract.balanceOf(to));
}