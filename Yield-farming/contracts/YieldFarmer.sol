pragma solidity >=0.7.3;
pragma experimental ABIEncoderV2;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract YieldFarmer {
  enum Protocol { A. B, C };
  Protocol public currentProtocol;
  IERC20 public token;

  constructor(address _token) {
    token = IERC20(_token);
  }

  function deposit(uint amount) external {
    token.transferFrom(msg.sender, address(this), amount);
    withdrawFrom(currentProtocol);
    _rebalance();
  }

  function withdraw(uint amount) external {
    withdrawFrom(currentProtocol);
    token.transfer(msg.sender, amount);
    _rebalance();
  }

  function rebalance() public {
    withdrawFrom(currentProtocol);
    _rebalance();
  }

  function _rebalance() internal {
    uint yieldA = getYieldA();
    uint yieldB = getYieldB();
    uint yieldC = getYieldC();

    if(yieldA >= yieldB && yieldA >= yieldC) {
      investTo(Protocol.A);
      currentProtocol = Protocol.A;
    } else if(yieldB >= yieldA && yieldB >= yieldC) {
      investTo(Protocol.B);
      currentProtocol = Protocol.B;
    } else if(yieldC >= yieldA && yieldC >= yieldB) {
      investTo(Protocol.C);
      currentProtocol = Protocol.C;
    }
  }

  //empty functions - need DEX/protocol specifics
  function withdrawFrom(Protocol protocol) internal {
  }

  function investTo(Protocol protocol) internal {
  }

  function getYieldA() public view returns(uint) {
  }
  function getYieldA() public view returns(uint) {
  }
  function getYieldA() public view returns(uint) {
  }

}
