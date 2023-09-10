// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Pair.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import {IERC20} from "./interfaces/IFactory.sol";

contract LiquidityProvider {
    address public tokenA;
    address public tokenB;
    address public uniswapRouter;

    uint256 public tokenABalance;
    uint256 public tokenBBalance;

    constructor(address _tokenA, address _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        uniswapRouter = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    }

    function getReserveA() public view returns (uint256) {
        return tokenA.balanceOf(address(this));
    }

    function getReserveB() public view returns (uint256) {
        return tokenB.balanceOf(address(this));
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {         
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);
        reserveA += amountA;
        reserveB += amountB;

        LiquidityProvider storage provider = liquidtyProvider[msg.sender];
            provider.amountA += AmountA;
            provider.amountB += AmountB;
            
        IERC20(tokenA).approve(uniswapRouter, amountA);
        IERC20(tokenB).approve(uniswapRouter, amountB);

        IUniswapV2Router02(uniswapRouter).addLiquidity(
            tokenA,
            tokenB,
            amountA,
            amountB,
            0,
            0,
            msg.sender,
            block.timestamp
        );

        tokenABalance = IERC20(tokenA).balanceOf(address(this));
        tokenBBalance = IERC20(tokenB).balanceOf(address(this));
    }

contract Swap is IERC20 {


    struct LiquidtyProvider {
        uint AmountA;
        uint AmountB;
    }

    mapping (address => LiquidityProvider) public liquidityProvider;

    constructor(address tokenA, address tokenB) {
        if (tokenA == address(0) && tokenB == address(o)) {
            revert null_address();
        }
        tokenAddyA = TokenA(tokenA);
        tokenAddyB = TokenB(tokenB);
    }

    function getReserveA() public view returns (uint256) {

    }


    // a sample code of how the addLiquidity function should be like
    

    function swap {

    }


// SPDX-License-Identifier: MIT








       
}

contract TokenSwap {
    IUniswapV2Router02 public uniswapRouter;
    address public tokenA;
    address public tokenB;
    address public owner;

    constructor(address _uniswapRouter, address _tokenA, address _tokenB) {
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
        tokenA = _tokenA;
        tokenB = _tokenB;
        owner = msg.sender;
    }
}

contract TokenSwap {
    IUniswapV2Router02 private uniswapRouter;
    address private tokenA;
    address private tokenB;
    address private owner;

    constructor(address _uniswapRouter, address _tokenA, address _tokenB) {
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
        tokenA = _tokenA;
        tokenB = _tokenB;
        owner = msg.sender;
    }
}

function swap(uint256 amountIn) external {
    require(amountIn > 0, 'Amount must be greater than zero');

    // Approve the router to spend token A
    IERC20(tokenA).approve(address(uniswapRouter), amountIn);

    // Define the path for the swap
    address[] memory path = new address[](2);
    path[0] = tokenA;
    path[1] = tokenB;

    // Perform the swap
    uniswapRouter.swapExactTokensForTokens(
        amountIn,
        0,
        path,
        address(this),
        block.timestamp + 3600
    );
}
