import Compound from '@compound-finance/compound-js';

//from infura.io new Compound Dashboard project
const provider = 'https://mainnet.infura.io/v3/0137d9c5e4c347188b2f451f52b4cb20';

//smart contract addresses:
const comptroller = Compound.util.getAddress(Compound.Comptroller); //address - comptroller
const opf = Compound.util.getAddress(Compound.PriceFeed); //address -compound price oracle

const cTokenDecimals = 8; //cTokens always have 8 decimals
const blocksPerDay = 4 * 60 * 24;
const daysPerYear = 365;
const ethMantissa = Math.pow(10, 18); //to convert from/to decimals

async function calculateSupplyApy(cToken) {
  const supplyRatePerBlock = await Compound.eth.read(
    cToken,
    'function supplyRatePerBlock() returns(uint)', //function signature - from Compound repo, file cToken
    [],           // [optional] parameters
    { provider }  // [optional] call options, provider, network, ethers.js "overrides"
  );
  return 100 * (Math.pow((supplyRatePerBlock / ethMantissa * blocksPerDay) + 1, daysPerYear - 1) - 1);
}

async function calculateCompApy(cToken, ticker, underlyingDecimals) {
  //amount of COMP tokens distributed to lenders or borrowers for the given market:
  let compSpeed = await Compound.eth.read(
    comptroller,
    'function compSpeeds(address cToken) public view returns(uint)',
    [ cToken ],
    { provider }
  );
  //COMP price from the compound price oracle:
  let compPrice = await Compound.eth.read(
    opf,
    'function price(string memory symbol) external view returns(uint)',
    [ Compound.COMP ],  //COMP address
    { provider }
  );
  //price of the underlying token
  let underlyingPrice = await Compound.eth.read(
    opf,
    'function price(string memory symbol) external view returns(uint)',
    [ ticker ],
    { provider }
  );
  //total supply of cToken emitted:
  let totalSupply = await Compound.eth.read(
    cToken,
    'function totalSupply() public view returns(uint)',
    [],
    { provider }
  );
  // Token / cToken exchange rate:
  let exchangeRate = await Compound.eth.read(
    cToken,
    'function exchangeRateCurrent() public view returns(uint)',
    [],
    { provider }
  );

  compSpeed = compSpeed / 1e18;
  compPrice = compPrice / 1e6;
  underlyingPrice = underlyingPrice / 1e6;
  exchangeRate = +exchangeRate.toString() / ethMantissa;
  totalSupply = +totalSupply.toString() * exchangeRate * underlyingPrice / Math.pow(10, underlyingDecimals);
  const compPerDay = compSpeed * blocksPerDay;

  console.log(
    'compSpeed:', compSpeed,
    'compPrice:', compPrice,
    'underlyingPrice:', underlyingPrice,
    'totalSupply:', totalSupply,
    'exchangeRate:', exchangeRate,
    'compPerDay:', compPerDay
  )

  return 100 * (compPrice * compPerDay / totalSupply) * 365;
}

async function calculateApy(cTokenTicker, underlyingTicker) {
  const underlyingDecimals = Compound.decimals[cTokenTicker.slice(1, 10)];
  const cTokenAddress = Compound.util.getAddress(cTokenTicker);
  const [supplyApy, compApy] = await Promise.all([
    calculateSupplyApy(cTokenAddress),
    calculateCompApy(cTokenAddress, underlyingTicker, underlyingDecimals)
  ]);
  return {ticker: underlyingTicker, supplyApy, compApy};
}

export default calculateApy;
