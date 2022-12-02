pragma solidity >=0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './ComptrollerInterface.sol';
import './CTokenInterface.sol';
import './PriceOracleInterface.sol';

contract MyDeFiProject {
  ComptrollerInterface public comptroller;
  PriceOracleInterface public priceOracle;

  constructor(
    address _comptroller,
    address _priceOracle
  ) {
    comptroller = ComptrollerInterface(_comptroller);
    priceOracle = PriceOracleInterface(_priceOracle);
  }

  function supply(address cTokenAddress, uint underlyingAmount) external {
    CTokenInterface cToken = CTokenInterface(cTokenAddress);
    address underlyingAddress = cToken.underlying();
    IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
    uint result = cToken.mint(underlyingAmount);
    //if failed returns !=0
    require(
      result == 0,
      'cToken.mint() failed. See Compound ErrorReporter.sol for more details'
    );
  }

  fnction redeem(address cTokenAddress, uint cTokenAmount) external {
    CTokenInterface cToken = CTokenInterface(cTokenAddress);
    //also cToken.redeemUnderlying to redeem the underlying token
    uint result = cToken.redeem(cTokenAmount);
    require(
      result == 0,
      'cToken.redeem() failed. See Compound ErrorReporter.sol for more details'
    );
  }

  function enterMarket(address cTokenAddress) external {
    address[] memory markets = new address[](1);
    markets[0] = cTokenAddress;
    uint[] memory results = comptroller.enterMarkets(markets);
    require(
      results[0] == 0,
      'comptroller.enterMarkets() failed. See Compound ErrorReporter.sol for more details'
    );
  }

  function borrow(address cTokenAddress, uint borrowAmount) external {
    CTokenInterface cToken = CTokenInterface(cTokenAddress);
    address underlyingAddress = cToken.underlying();
    uint result = cToken.borrow(borrowAmount);
    require(
      result == 0,
      'cToken.borrow() failed. See Compound ErrorReporter.sol for more details'
    );
  }

  function repayBorrow(address cTokenAddress, uint underlyingAmount) external {
    CTokenInterface = CTokenInterface(cTokenAddress);
    address underlyingAddress = cToken.underlying();
    IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
    uint result = cToken.repayBorrow(underlyingAmount);
    require(
      result == 0,
      'cToken.repay() failed. See Compound ErrorReporter.sol for more details'
    );
  }
}
