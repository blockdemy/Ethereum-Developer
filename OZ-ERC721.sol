// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract GameItem is ERC721URIStorage {

    uint256 private _counter;
    constructor() ERC721("GameItem", "ITM") {
        _counter = 0;
    }

    function mint (address _receiver, string memory _tokenURI) public {
        require(_counter < 1000, "Minted All"); 
        _counter++;

        _mint(_receiver, _counter);
        _setTokenURI(_counter, _tokenURI);
    }
    
}
