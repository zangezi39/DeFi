import { useState, useEffect } from 'react';
import getBlockchain from './ethereum.js';
import addresses from './addresses.js';
import { ethers } from 'ethers';

function App() {

const [yieldFarmer, setYieldFarmer] = useState(undefined);
const [dai, setDai] = useState(undefined);

useEffect(() => {
  const init = async () => {
    const { signerAddress, yieldFarmer, dai } = await getBlockchain();
    setYieldFarmer(yieldFarmer);
    setDai(dai);
  };
  init();
}, []);

const openPosition = async e => {
  e.preventDefault();
  const amountProvided = ethers.utils.parseUnits(e.target.elements[0].value, 18);
  const amountBorrowed = ethers.utils.parseUnits(e.target.elements[1].value, 18);
  const tx1 = await dai.approve(yieldFarmer.address, amountProvided.add('2'));
  await tx1.wait();
  const tx2 = await yieldFarmer.openPosition(
    addresses.solo,
    addresses.dai,
    addresses.cDai,
    amountProvided,
    amountBorrowed
  );
  await tx2.wait();
};

const closePosition = async e => {
  e.preventDefault();
  const tx1 = await dai.approve(yieldFarmer.address, '2');
  await tx1.wait();
  const tx2 = await yieldFarmer.closePosition(
    addresses.solo,
    addresses.dai,
    addresses.cDai
  );
  await tx2.wait();
};

if(
  typeof yieldFarmer === 'undefined'
) {
  return 'Loading...';
}

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
