// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract dataTypeReferencia{

    //Array fijo 
    uint[] public numeros;

    //Array dinámico 
    int[3] public cantidades;

    //miembros de Arrays

    //Length - Tamaño 
    uint numerosL = numeros.length;

    //Push - Añadir. Pop - Sacar
    function numerosMiembros() public{

        numeros.push(5);
        numeros.push(6);
        numeros.pop();

       numerosL = numeros.length;
    }
    

    //Struct 
    struct Persona{
        bool vacunado; 
        uint8 edad;
        bytes32 nombre; 
    }

    Persona public p1 = Persona(true, 30, "Lizeth");

    Persona public p2 = Persona({
        edad: 30,
        vacunado: false,
        nombre: "Luis"
    });

    uint8 public getEdad = p1.edad;

    /**************/
    //Mapping - mapping(_KeyType => _ValueType) [keyTipe] = valueType

    mapping(address => Persona) public diccPersona; 

    function addPersona() public {
        diccPersona[msg.sender] = p1;
    }


}
