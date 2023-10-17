const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CryptoAqsha", function () {
  let owner;
  let CryptoAqsha;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();
    const CryptoAqshaFactory = await ethers.getContractFactory("CryptoAqsha");
    CryptoAqsha = await CryptoAqshaFactory.deploy(owner.address);

    await CryptoAqsha.deployed();
  });

  it("should have the correct name and symbol", async function () {
    const name = await CryptoAqsha.name();
    const symbol = await CryptoAqsha.symbol();

    expect(name).to.equal("CryptoAqsha");
    expect(symbol).to.equal("CAQ");
  });

  it("should allow the owner to mint a token with a URI", async function () {
    const tokenURI = "https://example.com/token/1";
    await CryptoAqsha.safeMint(owner.address, tokenURI);

    const tokenId = 0;

    const tokenOwner = await CryptoAqsha.ownerOf(tokenId);
    expect(tokenOwner).to.equal(owner.address);

    const retrievedTokenURI = await CryptoAqsha.tokenURI(tokenId);
    expect(retrievedTokenURI).to.equal(tokenURI);
  });

});
