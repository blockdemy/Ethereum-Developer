// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract VisibilidadFunciones{
    
    int internal puntosTotales;
    int  puntosIn;

    //Private - Solo pueden ser llamadas desde el mismo contrato 
    function asignarPuntos(int _p1) private{
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
    function agregarPuntosVIP(int _p1) public{
       require(_p1 > 0, "No puedes agregar 0 Puntos");
       agregarPuntos(_p1);
       puntosTotales = 10*puntosTotales; 
    }

    //public - Puede llamarse desde otro contrato y genera un getter
    function verPuntos() public view returns(int){
        return puntosTotales;
    }

   //External - Se llaman expliciatemente y desde otros contratos 
    function obtenerSender()external view returns(address){
        return sender;
    }

    function getDatos() public view returns (address, int, address){
        return (this.obtenerSender(), puntosTotales, address(this));
    }

    function calcularPorcentaje10(int _numero)public pure returns(int) {
        return _numero*10;
    }

    constructor(){
        sender = msg.sender;
        agregarPuntosVIP(5);
    }

}
