pragma solidity >=0.7.3;

//interface to trigger event on user's side
interface IFlashloanUser {
  function flashloanCallback(
    uint amount,
    address token,
    bytes memory data
  )
  external;
}
