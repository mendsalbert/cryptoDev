require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-etherscan");

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;

const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [
        "7a7af74f631ff89ba62c48d8029ca2b353fc5b384558ff47f1ad9ba5c1d52ccf",
      ],
    },
  },

  etherscan: {
    apiKey: {
      polygonMumbai: "7EYZVIBKUI3WF1Q7XG5PP34VZSH5IQ1SX3",
    },
  },
};
