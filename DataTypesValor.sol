// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract DataTypeValor{

    //Booleano
    bool flagVerdadero = true;
    bool flagFalso = false;

    //**************************************/

    //Enteros con signo 
    
    //* 256 bits 
    int number1 = -8;

    //*8 bits
    int8 number2 = -8;

    int16 number3 = -8;

    //*256 bits
    int256 number10 = -8;

    //Enteros sin signo

    //* 256 bits 
    uint number4 = 8;

    //*8 bits
    uint8 number5 = 8;

    //*32 bits
    uint32 number6 = 8;

    //**************************************/

    //Address - 20 bytes - Direcciones Ethereum 
    
    //* Address del contract acount 
    address public addressAcount = address(this);

    //* Address de la externally owned account 
    address public addressExternally = msg.sender;

    //Propiedades de address

    //*Balance 
    uint public balanceAddressAcount = addressAcount.balance;
 
    uint public balanceAddresExternally = addressExternally.balance;

    //**************************************/

    //Arrays de tamaño fijo bytes1 - bytes32

    //1 byte - 8 bits 
    bytes1 data = "9";

    bytes2 data2 = "90";

    bytes32 data3 = "Hello world";

    //Propiedades de bytes 

    //*Tamaño
    uint public lenghtData1 = data.length;

    uint public lenghtData2 = data2.length;

}
