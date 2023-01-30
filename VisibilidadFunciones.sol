// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract VisibilidadFunciones{
    
    //*********Programa de Recompensas

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

    address public owner;

    constructor(){
        owner = msg.sender;
        agregarPuntosVIP(5);
    }

    function agregarPuntosVIP(int _p1) public onlyAdmin{
       require(_p1 > 0, "No puedes agregar 0 Puntos");
       agregarPuntos(_p1);
       puntosTotales = 10*puntosTotales; 

       emit AgregarPuntosVIP(_p1, owner);
    }

    //public - Puede llamarse desde otro contrato y genera un getter
    function verPuntos() public view returns(int){
        return puntosTotales;
    }

   //External - Se llaman expliciatemente y desde otros contratos 
    function obtenerOwner()external view returns(address){
        return owner;
    }

    function getDatos() public view returns (address, int, address){
        return (this.obtenerOwner(), puntosTotales, address(this));
    }

    function calcularPorcentaje10(int _numero)public pure returns(int) {
        return _numero*10;
    }

    //Modifiers - Se debe cumplir esta condición antes de ejecutar la función
    modifier onlyAdmin(){
        require(msg.sender == 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db , "No eres el Admin");
        _;
    }

    //Eventos - Notifica el status de la blockchain al exterior
    event AgregarPuntosVIP(int _p1, address owner);

}
