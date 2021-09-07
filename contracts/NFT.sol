//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    //allows us to increment the token id when a new token is minted
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //address that interacts with the marketplace
    address contractAddress;

    constructor(address marketplaceAddress) ERC721("Pomodori Tokens", "PDR") {
        contractAddress = marketplaceAddress;
    }

    //create the tokens
    function createToken(string memory tokenURI) public returns (uint256) {
        //increments each new token's id
        _tokenIds.increment();

        //gets the id of the current token
        uint256 newItemId = _tokenIds.current();

        //mint this new token
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        //gives marketplace approval to transact token between users.
        setApprovalForAll(contractAddress, true);

        return newItemId;
    }
}
