import { ethers } from "hardhat";
import { IUniswap__factory } from "../typechain-types";

async function main () {
    const uniswapAddr = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'
    const TokenA = '0xde79380FBd39e08150adAA5C6c9dE3146f53029e'
    const TokenB = '0xbFD3c8A956AFB7a9754C951D03C9aDdA7EC5d638'

    const path = [TokenA, TokenB]
    const to = '0xFABB0ac9d68B0B445fB7357272Ff202C5651694a'
    const currentTimestampInSeconds = Math.round(Date.now() / 1000)
    const deadline = currentTimestampInSeconds + 86400

    const uniswap = await ethers.getContractAt("IUniswap", uniswapAddr)
    const TokenAcontract = await ethers.getContractAt("IERC20", TokenA)
    const TokenBcontract = await ethers.getContractAt("IERC20", TokenB)

    
}