# ERC20 Token Project

This repository contains a custom ERC20 token implementation built with Solidity and tested using the Foundry framework. The project demonstrates a complete workflow from token implementation to deployment and testing.

## Overview

The project implements a standard ERC20 token with the following components:
- Token contract with standard ERC20 functionality
- Deployment scripts for various networks
- Comprehensive test suite using Foundry

## Technical Stack

- **Smart Contract**: Solidity
- **Development Framework**: Foundry
- **Testing**: Foundry Test Suite

## Installation and Setup

1. Install Foundry:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. Install OpenZeppelin contracts:
   ```bash
   forge install OpenZeppelin/openzeppelin-contracts
   ```

3. Update remappings (if needed):
   Add the following to `remappings.txt`:
   ```
   @openzeppelin/=lib/openzeppelin-contracts/
   ```


