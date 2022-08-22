require("@nomicfoundation/hardhat-toolbox");
const dotenv = require("dotenv");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    pd: {
      url: "http://35.188.148.32:8545/633501be-132b-4068-9940-ff39973d9db7",
      accounts: [`${process.env.PARADIGM_PRIVATE_KEY}`],
    },
  },
};
