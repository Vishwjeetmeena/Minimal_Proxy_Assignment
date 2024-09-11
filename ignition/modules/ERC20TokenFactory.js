const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ERC20TokenFactory", (m) => {
  const ERC20TokenFactory = m.contract("ERC20TokenFactory",[]);

  return { ERC20TokenFactory };
});