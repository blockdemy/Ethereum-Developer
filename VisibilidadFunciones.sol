// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract VisibilidadFunciones{
    
    int internal puntosTotales;
    int private puntosIn;

    //Private - Solo pueden ser llamadas desde el mismo contrato 
    function asignarPuntos(int _p1) private returns(int){
        puntosIn = _p1;
    }
    
    //internal - Pueden ser llamadas desde el mismo y los que derivan de ella
    function agregarPuntos(int _p1) internal{
        asignarPuntos(_p1);
        puntosTotales = puntosTotales + puntosIn;
    }

       
}

contract EjemploVisFun is VisibilidadFunciones{

    address public sender;
    function agregarPuntosVIP(int _p1) private{
       agregarPuntos(_p1);
       puntosTotales = 10*puntosTotales; 
    }

    //public - Puede llamarse desde otro contrato y genera un getter
    function verPuntos() public returns(int){
        return puntosTotales;
    }

   //External - Se llaman expliciatemente y desde otros contratos 
    function obtenerSender()external returns(address){
        return sender;
    }

    function getDatos() public returns (address, int, address){
        return (this.obtenerSender(), puntosTotales, address(this));
    }

    constructor(){
        sender = msg.sender;
        agregarPuntosVIP(5);
    }
}
