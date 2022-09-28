// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//Cuenta de ahorro

//En un inicio el saldo es cero. 

//Ingresar saldo 
//Retirar saldo 

//Valide si es posible ingresar o retirar valor

//Guardar mis datos
// Address de cuenta - Nombre, edad, color favorito.


contract CuentaAhorro{

//Datos

    struct Persona{
        uint8 edad;
        string nombre;
        string color;
        uint saldo;
    }

    Persona public p1;


    mapping (address => Persona) personas;
    

    address owner;

    constructor(uint8 _edad, string memory _nombre, string memory _color){

        p1.edad = _edad;
        p1.nombre = _nombre;
        p1.color = _color;
        p1.saldo = 0;

        owner = msg.sender;
        personas[owner] = p1; 
        
    }

    //Función que ingresa saldo
    function store (uint deposito) public{
        p1.saldo = p1.saldo + deposito;
        personas[owner] = p1; 
    }

    //Retiro - Funcion que retira saldo
    function retrieve (uint retiro) public{
        require(retiro < p1.saldo, "Saldo insuficiente");
        p1.saldo = p1.saldo - retiro;
        personas[owner] = p1; 
    }

    function getSaldo() public view returns(uint){
        return p1.saldo;
    }

    receive() external payable{
        p1.saldo = address(this).balance;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }


    
}

contract segundoContract{

    CuentaAhorro m = new CuentaAhorro(12, "Lizeth", "Morado");


    
    function operacion() public returns (uint){
        m.store(100);
        m.retrieve(5);
        uint saldo = m.getSaldo();
        return saldo;
    }

    function sendEtherTransfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }

}
