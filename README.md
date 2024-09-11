# ERC20 Token Factory

## Overview

This project implements an ERC20 Token Factory contract, which allows the deployment of multiple ERC20 token contracts using the [Clones](https://docs.openzeppelin.com/contracts/4.x/api/proxy#Clones) minimal proxy pattern. The factory provides two fee management modes: `FeeManager` and `ReferralManager`, which allow the deployer to choose different fee structures when creating new tokens. The ERC20 tokens are upgradeable, leveraging OpenZeppelin's `ERC20Upgradeable` contract.

## Features

- **Multiple ERC20 Token Deployment:** Deploy multiple ERC20 tokens using the factory contract with unique names, symbols, and total supplies.
- **Fee Management Modes:** Choose between two modes:
  - **FeeManager:** Deducts 0.0003% of the total supply as a fee during token deployment.
  - **ReferralManager:** Deducts 0.0002% of the total supply as a fee.
- **Upgradeable Tokens:** The ERC20 tokens deployed via the factory are upgradeable, allowing for future contract upgrades.
- **Access Control:** The owner of the factory has control over fee management modes.

## Prerequisites

Before using this project, make sure you have the following installed:

- [Node.js](https://nodejs.org/)
- [Hardhat](https://hardhat.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/your-repo/ERC20Factory.git
   cd ERC20Factory
