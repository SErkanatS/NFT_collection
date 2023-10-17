// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract CryptoAqsha is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    mapping(string => uint256) private uriToTokenId;
    
    event NFTCreated(address indexed owner, uint256 tokenId, string uri);

    constructor(address initialOwner)
        ERC721("CryptoAqsha", "CAQ")
        Ownable(initialOwner)
    {}

    function safeMint(address to, string calldata uri) public {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        uriToTokenId[uri] = tokenId;

        emit NFTCreated(to, tokenId, uri);
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override(ERC721, IERC721) {
        super.safeTransferFrom(from, to, tokenId, _data);
        emit Transfer(from, to, tokenId);
    }

    function getTokensForAddress(address owner) public view returns (string[] memory) {
        uint256 balance = balanceOf(owner);
        string[] memory ownedTokens = new string[](balance);

        uint256 ownedTokenCount = 0;
        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(owner, i);
            string memory uri = tokenURI(tokenId);
            ownedTokens[ownedTokenCount] = uri;
            ownedTokenCount++;
        }

        return ownedTokens;
    }

    function getTokenIdByURI(string calldata uri) public view returns (uint256) {
        return uriToTokenId[uri];
    }


}
