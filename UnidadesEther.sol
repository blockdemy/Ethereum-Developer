// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract UnidadesEther{

   uint public oneWei = 1 wei;
   uint public oneGwei = 1 gwei;
   uint public oneEther = 1 ether;

    bool public prueba1 = oneWei == 1;
    bool public prueba2 = oneGwei == 1e9; 
    bool public prueba3 = oneEther == 1e18; 
    
}
