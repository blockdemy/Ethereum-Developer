// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract dataTypesValor{


    //Booleanos
    bool flagTrue = true;
    bool flagFalse = false;

    /*****************************************************************/
    //Enteros 

    //int - Entero con signo y 256 bits
    int numero1 = -8;

    //int8 - Entero con signo y 8 bits
    int8 numero2 = -8;

    //uint - Entero sin signo y 256 bits
    uint numero10 = 8;

    /*****************************************************************/
    //Adress - 20 bytes. Dirección de Ethereum. 

    //*Address del contract account 
    address public addressContract = address(this); 

    //*Address de la externally owned account
    address public addressOwned = msg.sender;

    //Miembros de Address

    //*Balance - Monto de una dirección. 
    uint public addressContractBalance = addressContract.balance;

    /*****************************************************************/
    //Arrays de bytes de tamaño fijo - bytes 1 a bytes32

    //* 1 byte - 8 bits
    bytes1 data1 = "9";
    bytes32 data2 = "Hello world";

    //Miembros de bytes

    //* Tamaño 
    uint public lenghtData1 = data1.length;
    uint public lengthData2 = data2.length;

}
