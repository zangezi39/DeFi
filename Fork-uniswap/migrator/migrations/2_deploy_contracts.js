const BonusToken = artifacts.require("BonusToken.sol");
const LiquidityMigrator = artifacts.require("LiquidityMigrator.sol");

module.exports = async function (deployer) {
  await deployer.deploy(BonusToken);
  const bonusToken = await BonusToken.deployed();
//  await deployer.deploy(LiquidityMigrator);

  const routerAddress = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
  const pairAddress = '0xf8725ECFd022c81F74cB101Df2e0c6c4aD641821'; //fake for testing
  const routerForkAddress = '0x31d04d860E115b66d3FF217426074B4d476BBDB3';
  const pairForkAddress = '0x770b44f2eD9d9606BbA759d2cA1C213D1A4115dC'; //fake for testing

  await deployer.deploy(
    LiquidityMigrator,
    routerAddress,
    pairAddress,
    routerForkAddress,
    pairForkAddress,
    bonusToken.address
  );
  const liquidityMigrator = await LiquidityMigrator.deployed();
  await bonusToken.setLiquidator(liquidityMigrator.address);
};
