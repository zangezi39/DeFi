pragma solidity >=0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract GovernanceToken is ERC20, Ownable {

  //Address that deploys the contract is the owner of the contract:
  constructor() ERC20('Governance Token', 'GTK') Ownable()  {}

  function mint(address to, uint amount) external onlyOwner() {
    _mint(to, amount);
  }
}
