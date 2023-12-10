// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
  mapping(uint256 => string) private _tokenURIs;
    constructor() ERC721("MyERC721", "ARTSPRINT") {}

    function createToken(address recipient, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }
    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
    // Set the token URI for the given tokenId
    _tokenURIs[tokenId] = tokenURI;
}
}