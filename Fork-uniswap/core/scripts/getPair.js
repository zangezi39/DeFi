const UniswapV2Factory = artifacts.require('UniswapV2Factory.sol');

const token1Address = '0x8E24707919aCCAf5058FFcdaC808686CE018aA8a'; // rinkeby
const token2Address = '0xC618F1110f2327400Af6A8B0081DA5e7CD39B927'; // rinkeby

module.exports = async done => {
  const uniswapV2Factory = await UniswapV2Factory.deployed();
  const tokenPair = await uniswapV2Factory.getTokenPair(token1Address, token2Address);
  console.log(tokenPair);
  done();
}
