// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20} from "./interfaces/IFactory.sol";

contract ERC20 is IERC20 {
    mapping(address => uint256) _balance;
    mapping(address => mapping(address spender => uint256)) _allowance;
    uint256 _totalSupply;

    string public _name = "Scale";
    string public _symbol = "SCL";


    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

     function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual returns (uint256) {
        return _balance[account];
    }

    function transfer (address _to, uint256 _value) public returns (bool success) {
        require (_to != address(0), "transfer to address Zero not allowed");
        require (_value > 0, "increase value");
        require (balanceOf(msg.sender) >= _value, "insufficient funds");
        _balance[msg.sender] -= _value;
        _balance[_to] += _value;
        success = true;

    emit Transfer(msg.sender, _to, _value);
    }

    function transferFrom (address _from, address _to, uint256 _value) public returns (bool success) {
        require (_to != address(0), "transfer to address Zero not allowed");
        require (_value > 0, "increase value");
        require (balanceOf(_from) >= _value, "insufficient funds");
        require (allowance(_from, _to) <= _value, "insufficient allowance");
        _allowance[_from][_to] -= _value;
        _balance[_from] -= _value;
        _balance[_to] += _value;
        success = true;
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        _allowance[msg.sender][_spender] = _value;
        success = true;
        emit Approval(msg.sender, _spender, _value);
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return _allowance[_owner][_spender];

    }

    function mint (address _to, uint value) external {
        require (_to != address(0), "trasnfer to address Zero not allowed");
        _totalSupply += value;
        _balance[_to] += value;
        emit Minted(_to, value);
    }

    function burn(uint value, address target) external {
        require(balanceOf(msg.sender) >= value, "insufficient funds");
        _balance[msg.sender] -= value;
        uint burnValue = (value * 90) / 100;
        _totalSupply -= burnValue;
        _balance[target] = value - burnValue;
    }
}