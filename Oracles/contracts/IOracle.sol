pragma solidity >=0.7.3;

interface IOracle {
  function updateReporter(address reporter, bool isReporter) external;
  function updateData(bytes32 key, uint payload);
  function getData(bytes32 key)
    external
    view
    returns(bool result, uint date, uint payload);
}
