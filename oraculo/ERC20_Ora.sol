

// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./getEthPrice.sol";

contract ERC20BAM is ERC20, getEthPrice{
    //variables o constantes
        // definir el precio de cada token
    uint256 tokenPriceUSD = 10*10**8; 
    constructor() ERC20("Blockdemy Community Token", "BAMC") {
        _mint(address(this), 100000 * 10**18);
    }
    //  vender token a precio base
    function sellTokens(uint256 _amount) public payable returns (bool success){
        // verificar que lo que nos esté mandando como valor sea igual o mayor que el costo por cada token
        require( msg.value >= getCost(_amount) * 1 gwei , "No tienes los fondos suficientes");
        // validar que el contrato tenga los tokens que requiere
        require(_amount *10 **18 <= balanceOf(address(this)));
        // actualizar balances
        _transfer(address(this), msg.sender, _amount * 10 **18);
        // retornar cambio
        return true;

    }
    // obtener costo por token getCost
    function getCost(uint256 _amount) public view returns(uint256) {
        return (tokenPriceUSD * _amount *10**8) / uint256(getOnlyEthPrice());
    }

    function getContraBalance() public view returns(uint256){
        return address(this).balance;
    }
}

