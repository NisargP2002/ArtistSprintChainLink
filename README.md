# ArtistSprintChainLink
This repository contains Solidity smart contracts for an ArtSprint decentralized application. ArtSprint is a platform for creating and funding art projects using blockchain technology.

# Contracts
## 1. MyERC721.sol
This contract is an ERC-721 token contract representing unique art assets. It provides functionality to create new tokens with associated metadata.
* createToken: Creates a new ERC-721 token and assigns it to a specified recipient.

## 2. ArtSprint.sol
The ArtSprint contract manages art projects, investments, and the overall functionality of the ArtSprint platform. Users can create projects, invest in projects, and track their contributions.
* createProject: Allows users to create a new art project by specifying project details.
* getMyCreatedProjects: Retrieves a list of projects created by the sender.
* getAllActiveProjects: Retrieves details of all active projects.
* investInProject: Enables users to invest in a specific project.

## 3. PriceFeed.sol
PriceFeed is a simple contract that interfaces with a Chainlink price feed to get the latest price. This is used in ArtSprint to convert funding goals and investment amounts from Ether to USD or another fiat currency.
* getLatestPrice: Retrieves the latest price from the Chainlink price feed.

 # Development Environment

These contracts are developed and tested using Remix, an online Ethereum IDE.

1. Open [Remix](https://remix.ethereum.org/).
2. Create new files for each contract (`MyERC721.sol`, `ArtSprint.sol`, `PriceFeed.sol`).
3. Copy and paste the corresponding contract code into each file.
4. Deploy each contract using Remix's deployment environment.

# Dependencies

- **OpenZeppelin:** Contracts from the OpenZeppelin library, such as ERC721, are used.
- **Chainlink:** Integration with Chainlink is implemented through the `PriceFeed.sol` contract.

# Usage

1. Deploy the `MyERC721.sol` contract to manage NFTs.
2. Deploy the `PriceFeed.sol` contract and provide its address when deploying the `ArtSprint.sol` contract.
3. Use the `ArtSprint.sol` contract to create and invest in art projects.

# Disclaimer

This code is provided as-is, and users should exercise caution when deploying smart contracts. It is recommended to review and test thoroughly before deploying on a live blockchain.




