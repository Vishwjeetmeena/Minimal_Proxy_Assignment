#ERC20 Token Factory
##Overview
This project implements an ERC20 Token Factory contract, which allows the deployment of multiple ERC20 token contracts using the Clones minimal proxy pattern. The factory provides two fee management modes: FeeManager and ReferralManager, which allow the deployer to choose different fee structures when creating new tokens. The ERC20 tokens are upgradeable, leveraging OpenZeppelin's ERC20Upgradeable contract.

###Features
Multiple ERC20 Token Deployment: Deploy multiple ERC20 tokens using the factory contract with unique names, symbols, and total supplies.
Fee Management Modes: Choose between two modes:
FeeManager: Deducts 0.0003% of the total supply as a fee during token deployment.
ReferralManager: Deducts 0.0002% of the total supply as a fee.
Upgradeable Tokens: The ERC20 tokens deployed via the factory are upgradeable, allowing for future contract upgrades.
Access Control: The owner of the factory has control over fee management modes.

**Prerequisites**
Before using this project, make sure you have the following installed:

- Node.js
* Hardhat
+ OpenZeppelin Contracts

**Installation**
Clone this repository:

bash
Copy code
git clone https://github.com/your-repo/ERC20Factory.git
cd ERC20Factory
Install dependencies:

bash
Copy code
npm install
Compile the contracts:

bash
Copy code
npx hardhat compile
Deployment
To deploy the factory contract on your desired network:

Update the deployment script (if necessary) with your implementation contract address.

Deploy the factory contract:

bash
Copy code
npx hardhat run scripts/deploy.js --network <network_name>
Usage
Deploy a New ERC20 Token
To deploy a new ERC20 token contract via the factory:

Ensure the factory contract is deployed.

Call the deploy function from the factory contract with the token parameters:

name: The name of the new token.
symbol: The symbol of the new token.
totalSupply: The total supply of the new token.
salt: A unique value to ensure deterministic address creation.
Example:

solidity
Copy code
factory.deploy("MyToken", "MTK", 1000000, salt);
Toggling Fee Mode
The factory contract allows the owner to toggle between FeeManager and ReferralManager modes using the changeFeeMode function:

solidity
Copy code
factory.changeFeeMode();
Predicting Token Address
To predict the address of a future deployed token contract, call getCloneAddress with the desired salt value:

solidity
Copy code
factory.getCloneAddress(salt);
Events
Deploy(address proxyAddress, string name, string symbol, uint256 totalSupply): Emitted when a new token is deployed.
FeeMode(bool FeeManager, bool ReferralManager): Emitted when the fee mode is changed.
License
This project is licensed under the MIT License.
