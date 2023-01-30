// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract CuentaAhorro{

    //***CuentaAhorro 

    struct Persona{
        string nombre;
        uint8 edad;
        uint saldo;
    }

    mapping (address => Persona) public personas;

    function createPersona(string memory _nombre, uint8 _edad) public{
        //1. Crear a la persona 
        Persona memory p1 = Persona(_nombre, _edad, 0);

        //2. Agregarla al mapping de personas;
        personas[msg.sender] = p1;
    }


    //Función que ingresa saldo
    function store (uint _deposito) public{
        //1. Consultar a la persona a la que le agregaremos el saldo
        Persona memory p1 = personas[msg.sender];

        //2. Agregar saldo 
        p1.saldo = p1.saldo + _deposito;

        //3. Volver a agregar al mapping de personas
        personas[msg.sender] = p1; 
    }

    
    //Función que retira saldo
    function retrieve (uint _retiro) public{
        //1. Consultar a la persona a la que le retiramos el saldo
        Persona memory p1 = personas[msg.sender];

        //2. Verificar que el saldo sea mayor a lo que se quiere retirar
        require(p1.saldo > _retiro, "Saldo insuficiente");

        //2. retirar saldo 
        p1.saldo = p1.saldo - _retiro;

        //3. Volver a agregar al mapping de personas
        personas[msg.sender] = p1; 
        
    }

    //Función que consulta saldo
    function getSaldo() public view returns(uint){
        //1. Consultar a la persona a la que le consultaremos el saldo
        Persona memory p1 = personas[msg.sender];
        //2. Regresar el saldo
        return p1.saldo;
    }
    
}
