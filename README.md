# ArtistSprintChainLink
This repository contains Solidity smart contracts for an ArtSprint decentralized application. ArtSprint is a platform for creating and funding art projects using blockchain technology.

# Contracts
# 1. MyERC721.sol
This contract is an ERC-721 token contract representing unique art assets. It provides functionality to create new tokens with associated metadata.

# 2. ArtSprint.sol
The ArtSprint contract manages art projects, investments, and the overall functionality of the ArtSprint platform. Users can create projects, invest in projects, and track their contributions.

# 3. PriceFeed.sol
PriceFeed is a simple contract that interfaces with a Chainlink price feed to get the latest price. This is used in ArtSprint to convert funding goals and investment amounts from Ether to USD or another fiat currency.

