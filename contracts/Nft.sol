// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {}

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return string(abi.encodePacked("Here we can add our metadata"));
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function addMetadata(
        string memory _description,
        string memory _ext_url,
        string memory _img_url,
        string memory _name
    ) internal pure returns (string memory) {
        return (
            string(
                abi.encodePacked(
                    "{",
                    "description",
                    ":",
                    _description,
                    "external_url",
                    ":",
                    _ext_url,
                    "image",
                    ":",
                    _img_url,
                    "name",
                    ":",
                    _name,
                    "attributes",
                    ":",
                    "[]",
                    "}"
                )
            )
        );
    }
}
