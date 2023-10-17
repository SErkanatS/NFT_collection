async function main() {
   const [deployer] = await ethers.getSigners();

   console.log("Deploying contracts with the account:", deployer.address);

   const token = await ethers.deployContract("CryptoAqsha",[deployer.address]);

   console.log("CryptoAqsha address:", await token.getAddress());
}

main()
   .then(() => process.exit(0))
   .catch((error) => {
      console.error(error);
      process.exit(1);
   });