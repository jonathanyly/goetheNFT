// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GoetheNFT is ERC721, ERC721URIStorage {

    address owner;

    string[] public Matrikelnummern;
    
    using Counters for Counters.Counter;

    string internal uri = "QmZdZCEN3Mn4DaScyTDUgAwQTpXKqzVUw7bhw3R8Gt4MNa";

    string public Matrikelnummer = "Please input your Matrikelnummer!";

    bool public valid_matrikelnr;

    Counters.Counter private _tokenIdCounter;

    constructor(string[] memory _Matrikelnummern) ERC721("Goethe NFTV5", "GOETHE") {
        Matrikelnummern = _Matrikelnummern;
        owner = msg.sender;
    }
    
    modifier _onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }
    
    function addmatrikelnr(string memory _Matrikelnummer) public _onlyOwner {
        Matrikelnummern.push(_Matrikelnummer);
    }
    

    function validiation() internal {
        for (uint i = 0; i < Matrikelnummern.length; i++) {
            if (keccak256(abi.encodePacked(Matrikelnummer)) == keccak256(abi.encodePacked(Matrikelnummern[i]))) {
                valid_matrikelnr = true;
            }
        }
    }
    
    function delete_matrikelnr() internal {
        for (uint i = 0; i < Matrikelnummern.length; i++) {
            if (keccak256(abi.encodePacked(Matrikelnummer)) == keccak256(abi.encodePacked(Matrikelnummern[i]))) {
                delete Matrikelnummern[i];
                valid_matrikelnr = false;
            } 
        }
    }

    function safeMint(address to, string memory _Matrikelnummer) public  {
        Matrikelnummer = _Matrikelnummer;
        validiation();
        require(valid_matrikelnr == true, "Matrikelnummer wurde nicht in der Datenbank gefunden!");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        delete_matrikelnr();
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

