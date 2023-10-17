require('@nomicfoundation/hardhat-toolbox');
require('dotenv').config()
require('hardhat-deploy');

module.exports = {
	solidity: {
		version: "0.8.20",
		settings: {
			optimizer: {
				enabled: true
			}
		}
	},
	allowUnlimitedContractSize: true,
	networks: {
		hardhat: {
			chanId: 31337
		},
		sepolia: {
			url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,
			accounts: [`${process.env.PRIVATE_KEY}`]
		}
	},
	paths: {
		artifacts: '../frontend/artifacts'
	}
}