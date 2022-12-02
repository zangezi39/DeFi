pragma solidity ^0.6.6;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract BonusToken is ERC20 {
  address public admin;
  address public liquidator;
  constructor() ERC20('Bonus Token', 'BTK') public {
    admin = msg.sender;
  }

  function setLiquidator(address _liquidator) external {
    require(msg.sender == admin, 'admin only');
    liquidator = _liquidator;
  }

  // Mints bonus tokens
  function mint(address to, uint amount) external {
    require(msg.sender == liquidator, 'liquidator only');
    // _mint() inherited from openzeppelin ERC20
    _mint(to, amount);
  }
}
