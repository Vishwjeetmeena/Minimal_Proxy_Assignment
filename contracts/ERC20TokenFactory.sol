// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Token} from "./ERC20Token.sol";

/**
 * @title ERC20TokenFactory
 * @dev Factory contract to deploy ERC20 token contracts using the minimal proxy pattern (Clones).
 * The factory allows setting a fee mode and provides a deterministic way to predict addresses.
 */
contract ERC20TokenFactory is Ownable {

    /// @notice The address of the ERC20 token implementation contract used for deploying proxies.
    address public immutable implementation;

    /// @notice Indicates if the fee manager is active.
    bool public FeeManager;

    /// @notice Indicates if the referral manager is active.
    bool public ReferralManager;

    /// @notice Indicates amount of fees which will be deducted in deploying clone.
    uint256 public fee;
    
    struct Proxy {
        address proxyAddress;
        string name;
        string symbol;
        uint totalSupply;
    }

    /// @notice stores all the proxys which are deployed
    Proxy[] public factory;

    
    ///@dev Emitted when new clone is deployed
    event Deploy(address indexed proxyAddress, string indexed name, string indexed symbol, uint256 totalSupply);
    
    ///@dev Emitted when fee mode is changed
    event FeeMode(bool indexed FeeManager, bool indexed ReferralManager);


    /**
     * @dev Initializes the factory with the address of the ERC20 token implementation contract.
     * @param _implementation The address of the ERC20 token implementation contract.
     */
    constructor(address _implementation) Ownable(msg.sender) {
        implementation = _implementation;
        FeeManager = true;
    }

    /**
     * @notice Deploys a new ERC20 token contract as a minimal proxy using a deterministic address.
     * @dev Uses the Clones library to create a new proxy contract and initializes it with the provided parameters.
     * @param name The name of the new ERC20 token.
     * @param symbol The symbol of the new ERC20 token.
     * @param totalSupply The total supply of the new ERC20 token.
     * @param salt A unique value to ensure the determinism of the proxy contract address.
     */
    function deploy(
        string calldata name,
        string calldata symbol,
        uint256 totalSupply,
        bytes32 salt
    ) external {
        
        if (ReferralManager) {
            fee = (2 * totalSupply) / 1000000; 
        } else {
            fee = (3 * totalSupply) / 1000000;
        }

        address newcontract = Clones.cloneDeterministic(implementation, salt);

        factory.push(Proxy(newcontract, name, symbol, totalSupply));

        ERC20Token(newcontract).initialize(name, symbol, msg.sender, totalSupply-fee, owner(), fee);

        emit Deploy(newcontract, name, symbol, totalSupply);
    }

    /**
     * @notice Toggles the fee mode between FeeManager and ReferralManager.
     * @dev Only the contract owner can call this function.
     */
    function changeFeeMode() public onlyOwner {
        FeeManager = !FeeManager;
        ReferralManager = !ReferralManager;
        emit FeeMode(FeeManager, ReferralManager);
    }

    /**
     * @notice Predicts the address of a proxy contract that would be deployed using the provided salt.
     * @param salt The salt used to compute the deterministic address.
     * @return The predicted address of the proxy contract.
     */
    function getCloneAddress(bytes32 salt) external view returns (address) {
        return Clones.predictDeterministicAddress(implementation, salt);
    }
}
