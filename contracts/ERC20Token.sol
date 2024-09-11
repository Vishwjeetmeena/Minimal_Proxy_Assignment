// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

/// @title ERC20Token Contract
/// @notice This contract is an upgradeable implementation of an ERC20 token.
/// It extends OpenZeppelin's ERC20Upgradeable contract and adds an initialize function
/// for setting up the token parameters. The contract also mints the initial total supply 
/// to the specified owner and a fee to the factory address.
/// @dev The initialize function replaces a constructor in upgradeable contracts.
/// It ensures the contract is initialized only once, using OpenZeppelin's initializer modifier.
contract ERC20Token is ERC20Upgradeable {

    /**
     * @notice Initializes the ERC20 token with the given parameters.
     * @dev The initializer modifier ensures this function can only be called once.
     * The ERC20 token is set up with the specified name, symbol, owner, total supply, 
     * and an additional fee to the factory address.
     * @param name The name of the token.
     * @param symbol The symbol of the token.
     * @param owner The address to receive the initial total supply of tokens.
     * @param totalSupply_ The total supply of the token to be minted to the owner after fees deduction.
     * @param ERC20TokenFactory The address of the factory to receive the fee.
     * @param fee The amount of tokens to mint as a fee to the factory.
     */
    function initialize(
        string calldata name,
        string calldata symbol,
        address owner,
        uint256 totalSupply_,
        address ERC20TokenFactory,
        uint256 fee
    ) external initializer() {
        __ERC20_init(name, symbol); // Initialize the ERC20 token with name and symbol.
        _mint(owner, totalSupply_); // Mint total supply to the owner's address.
        _mint(ERC20TokenFactory, fee); // Mint fee amount to the factory's address.
    }
}
