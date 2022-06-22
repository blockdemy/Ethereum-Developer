// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20OpenZ is ERC20{
    constructor() ERC20 ("LizToken", "LTK"){
        //Indicar total supply
        _mint(msg.sender, 1000*10**decimals());
    }
}
