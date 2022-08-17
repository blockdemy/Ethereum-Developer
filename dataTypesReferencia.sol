// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract dataTypesReferencia{


    //Struct
    struct Persona{
        bool vacunado;
        uint8 edad;
        bytes32 nombre;
    }

    Persona public p1 = Persona(true, 32, "Lizeth");
    Persona public p2 = Persona({
        edad: 30,
        vacunado: true, 
        nombre: "Lizeth"});

    uint8 public edadP1 = p1.edad;

    /*****************************************************************/
    
    //Mapping - mapping(_KeyType => _ValueType)

    mapping(address => Persona) diccPersonas; 

    function addPersona() public{
        diccPersonas[msg.sender] = p1;
    }
    

}
