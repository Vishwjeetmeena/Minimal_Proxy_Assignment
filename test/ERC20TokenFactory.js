const {loadFixture,} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
//const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("ERC20TokenFactory", function () {

  async function deployTokenFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    // deploy the implementation contract
    const ERC20Token = await ethers.deployContract("ERC20Token");
    console.log("Implementation contract address        ", ERC20Token.target);

    const ERC20TokenFactory = await ethers.deployContract("ERC20TokenFactory", [ERC20Token.target]);
    console.log("Minimal proxy factory contract address ", ERC20TokenFactory.target);
    

    return { owner, addr1, addr2, ERC20Token, ERC20TokenFactory };
  }



  it("Deployment should assign ERC20Token i.e implementation contract address in ERC20TokenFactory contract", async function () {

    const { ERC20Token, ERC20TokenFactory } = await loadFixture(deployTokenFixture);
    expect(await ERC20TokenFactory.implementation()).to.equal(ERC20Token.target);

  });

  it("Should deploy clone", async function () {

    const {  owner, addr1, addr2, ERC20Token, ERC20TokenFactory } = await loadFixture(deployTokenFixture);

    const name = "My token";
    const symbol = "MTK";
    const totalSupply = 1000001n;
    const salt = "0x73616c7400000000000000000000000000000000000000000000000000000000"; // write revert conditon for same salt
    
    await ERC20TokenFactory.connect(addr1).deploy(name, symbol, totalSupply, salt)
    const proxyAddress = await ERC20TokenFactory.getCloneAddress(salt);
    const fee = await ERC20TokenFactory.fee();
    expect(await ERC20Token.attach(proxyAddress).balanceOf(owner.address)).to.equal(fee)
  })

  it("Should change the fee mode", async function () {

    const { ERC20TokenFactory } = await loadFixture(deployTokenFixture);

    await ERC20TokenFactory.changeFeeMode();
    const salt = "0x73616c7400000000000000000000000000000000000000000000000000000000";
    await ERC20TokenFactory.deploy("My token", "MTK", 1000000n, salt)

    expect(await ERC20TokenFactory.fee()).to.equal(2n);
  })

  it("Should fail if fee mode is not changed by owner", async function () {

    const { addr1,  ERC20Token, ERC20TokenFactory } = await loadFixture(deployTokenFixture);

    const salt = "0x73616c7400000000000000000000000000000000000000000000000000000000";
    await ERC20TokenFactory.deploy("My token", "MTK", 1000000n, salt);
    const proxyAddress = await ERC20TokenFactory.getCloneAddress(salt);
    await expect(ERC20Token.attach(proxyAddress).initialize("Token", "Tk", addr1.address, 1000000n, ERC20TokenFactory.target, 2))
    .to.be.revertedWithCustomError(ERC20Token, "InvalidInitialization");

    await expect(ERC20TokenFactory.connect(addr1).changeFeeMode()).to.be.revertedWithCustomError(ERC20TokenFactory, "OwnableUnauthorizedAccount").withArgs(addr1.address);
   
  })

});

