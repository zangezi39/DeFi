pragma solidity >=0.7.3;

import '@openzeppelin/contracts/toke/ERC20/ERC20.sol';

contract LpTokens is ERC20 {
  constructor() ERC('Liquidity Tokens', 'LPT') {}
}
