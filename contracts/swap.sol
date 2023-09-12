// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
import {IERC20} from "./interfaces/IFactory.sol";
 
contract Swap {
    address tokenA;
    address tokenB;
    uint tokenARes;
    uint tokenBRes;
    uint totalRes;

   struct LiquidityProvider{
    uint TokenA;
    uint TokenB;
   }

   mapping (address => LiquidityProvider) liquidityProvider;
   constructor(address _tokenA, address _tokenB) {
    tokenA = _tokenA;
    tokenB = _tokenB;
   }

   function addLiquidity(uint256 amountA, uint256 amountB) external {         
    IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
    IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);
    tokenARes += amountA;
    tokenBRes += amountB;
    Res(tokenARes, tokenBRes);

    LiquidityProvider storage provider = liquidityProvider[msg.sender];
        provider.TokenA += amountA;
        provider.TokenB += amountB; 
   }

   function removeLiquidity(uint256 amountA, uint256 amountB) external {
    LiquidityProvider storage provider = liquidityProvider[msg.sender];
    IERC20(tokenA).transfer(msg.sender, amountA);
    IERC20(tokenB).transfer(msg.sender, amountB);
    tokenARes -= amountA;
    tokenBRes -= amountB;
    Res(tokenARes, tokenBRes);

    provider.TokenA -= amountA;
    provider.TokenB -= amountB;
   }

   function Res(uint _tokenARes, uint _tokenBRes) public {
    totalRes = _tokenARes * _tokenBRes;
   }

   function TokenAReceive(uint amountIn /*uint amountOutMin*/) external view returns (uint amountToReceive) {
    amountToReceive = tokenARes - (totalRes / (tokenBRes - amountIn));
  }

   function TokenBReceive(uint amountIn /*uint amountOutMin*/) external view returns (uint amountToReceive) {
    amountToReceive = tokenBRes - (totalRes / (tokenARes - amountIn));
   }

   function swapTAforTB (uint amountIn, uint amountOutMin, address to) public {
    require(amountIn > 0, "No zero Amount");
    uint balance = IERC20(tokenA).balanceOf(msg.sender);
    require(balance > 0, "Balance cannot be zero");
    IERC20(tokenA).transferFrom(msg.sender, address(this), amountIn);
    uint amountToReceive = amountOutMin;
    bool success = IERC20(tokenB).transfer(to, amountToReceive);
    require(success, "Transfer Failed");
    tokenARes += amountIn;
    tokenBRes -= amountOutMin;
   }

   function swapTBforTA (uint amountIn, uint amountOutMin, address to) public {
    require(amountIn > 0, "No Zero Amount");
    uint balance = IERC20(tokenB).balanceOf(msg.sender);
    require(balance > 0, "Balance cannot be zero");
    IERC20(tokenB).transferFrom(msg.sender, address(this), amountIn);
    uint amountToReceive = amountOutMin;
    bool success = IERC20(tokenA).transfer(to, amountToReceive);
    require(success, "Transfer Failed");
    tokenBRes += amountIn;
    tokenARes -= amountOutMin;
   }
}

    