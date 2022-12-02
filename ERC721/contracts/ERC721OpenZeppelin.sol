pragma solidity >=0.7.0;

import '@openzeppelin/contracts/ERC721/ERC721.sol';

contract ERC721OpenZeppelin1 is ERC721 {
  constructor() ERC721('Token Name', 'Token Symbol') {}
}

contract ERC721OpenZeppelin2 is ERC721 {
  constructor() ERC721('Token Name', 'Token Symbol') {
    _safeMint(msg.sender, 0); //mints a single token only
    //to mint more tokens add for each additional token:
    //_safeMint(msg.sender, 1); etc
  }
}

contract ERC721OpenZeppelin3 is ERC721 {
  address public admin;
  constructor() ERC721('Token Name', 'Token Symbol') {
    admin = msg.sender;
  }

  function mint(address to, uint tokenid) external {
    require(msg.sender==admin, 'admin only');
    _safeMint(to, tokenId);
  }
}

contract ERC721OpenZeppelin4 is ERC721 {
  address public admin;
  constructor() ERC721('Token Name', 'Token Symbol') {}

  function faucet(address to, uint tokenid) external {
    _safeMint(to, tokenId);
  }
}
