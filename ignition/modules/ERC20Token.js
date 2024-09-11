const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ERC20Token", (m) => {
  const ERC20Token = m.contract("ERC20Token");

  return { ERC20Token };
});
