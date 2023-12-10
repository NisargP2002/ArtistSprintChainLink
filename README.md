# ArtistSprintChainLink
This repository contains Solidity smart contracts for an ArtSprint decentralized application. ArtSprint is a platform for creating and funding art projects using blockchain technology.

# Contracts
# 1. MyERC721.sol
This contract is an ERC-721 token contract representing unique art assets. It provides functionality to create new tokens with associated metadata.
* createToken: Creates a new ERC-721 token and assigns it to a specified recipient.

# 2. ArtSprint.sol
The ArtSprint contract manages art projects, investments, and the overall functionality of the ArtSprint platform. Users can create projects, invest in projects, and track their contributions.
* createProject: Allows users to create a new art project by specifying project details.
* getMyCreatedProjects: Retrieves a list of projects created by the sender.
* getAllActiveProjects: Retrieves details of all active projects.
* investInProject: Enables users to invest in a specific project.

# 3. PriceFeed.sol
PriceFeed is a simple contract that interfaces with a Chainlink price feed to get the latest price. This is used in ArtSprint to convert funding goals and investment amounts from Ether to USD or another fiat currency.
* getLatestPrice: Retrieves the latest price from the Chainlink price feed.


