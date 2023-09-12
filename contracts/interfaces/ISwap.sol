// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

interface ISwap {
    function addLiquidity (uint256 amountA, uint256 amountB) external;
    function removeLiquidity(uint256 amountA, uint256 amountB) external;
    function swapTokenAforTokenB(uint amountIn, uint amountOutMin, address to) external;
    function swapTokenBforTokenA(uint amountIn, uint amountOutMin, address to) external;
}