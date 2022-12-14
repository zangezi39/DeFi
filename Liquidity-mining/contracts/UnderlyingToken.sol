pragma solidity >=0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract UnderlyingToken is ERC20 {
  constructor() ERC20('Underlying Token', 'UTK') {}

  //faucet for development only - do not include in production
  function faucet(address to, uint amount) external {
    _mint(to, amount);
  }
}
