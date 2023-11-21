// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract SendEther{

     //send() - Ya no se usa. No revierte la transacción. Para eso se usa require 
     //Permite 2300 unidades de gas
    function sendEtherSend(address payable _to) public payable{
        bool sent = _to.send(msg.value);
        require (sent, "Error");
    }


    //transfer() - Si no se puede, se revierte la transacción
    //Permite 2300 unidades de gas
    function sendEtherTransfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }
    
   
    //call()
    //Permite todo el gas displonible. pPsibilidad de un retorno de datos desde la función receptor.
    function sendEtherCall(address payable _to) public payable returns (bytes memory) {
        (bool sent,  bytes memory data ) = _to.call{value: msg.value, gas: 10000}("");
        require (sent, "Error");
        return data;

    }
}


contract RecibirEther{

    //getBalance()
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    //receive()
    receive() external payable{

    }
    //fallback()
    fallback() external payable{

    }
    
}
