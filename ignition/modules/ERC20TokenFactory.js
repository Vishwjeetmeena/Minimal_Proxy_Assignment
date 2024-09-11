const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ERC20TokenFactory", (m) => {
  
  const implementationAddress = "0xF99CBcEe50F986FcC3A62118fE092CB7E7107ce4";

  const ERC20TokenFactory = m.contract("ERC20TokenFactory", [implementationAddress]);

  return { ERC20TokenFactory };
});
