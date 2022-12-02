const UniswapV2Factory = artifacts.require('UniswapV2Factory.sol');

const token1Address = '0xe26D4D7D7EB47d8261d5f4227d5367d48fD05E3B'; // rinkeby
const token2Address = '0x444BBC41D1a6BC3890334839FAC898Bbf736c6B0'; // rinkeby

module.exports = async done => {
  const uniswapV2Factory = await UniswapV2Factory.deployed();
  await uniswapV2Factory.createPair(token1Address, token2Address);
  done();
}
