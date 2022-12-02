pragma solidity >=0.7.3;

import '@openzeppelin/contracts/tokenERC20/ERC20.sol';

//WIP
contract StableCoin is ERC20{
  address public oracle;
  uint public targetPrice = 10 ** 18; //1 token = 10 ** 18 = 1 US$
  uint public initialSupply = 100000 * 10 * 18; //100,000 tokens
  uint public treasury = 10000; //10,000 tokens

  struct Position {
    uint collateral;
    uint token;
  }
  mapping(address => Position) public positions;
  uint public collatFactor = 150;

  constructor(address _oracle) ERC20 {
    oracle = _oracle;
    _mint(msg.sender, initialSupply);
  }

  function adjustSupply(uint price) external {

  }
}
