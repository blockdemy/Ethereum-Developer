// SPDX-License-Identifier: UNLICENSED;
pragma solidity 0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract ERC20 is IERC20{

    //Variables 

    //NOMBRE
    string public constant name = "Blockdemy Community Token";

    //SIMBOLO
    string public constant symbol = "BAM";

    // DECIMALES
    uint8 public constant decimals = 18;

    //TOTAL SUPPLY
    // 10 ether ===> 10 000000000000000000
    uint256 totalSupply_ = 10 ether;


    //BALANCES
    mapping (address => uint256) balances;

    //ALLOWED
    mapping(address => mapping (address=> uint256)) allowed;

    constructor(){
        balances[msg.sender] = totalSupply_;
    }

    //Funciones
    
    //TotalSupply retorna el total supply
    function totalSupply() external override view returns (uint256){
        return totalSupply_;
    }

    //Devolver el balance de una cuenta en especifico.
    function balanceOf(address _owner) external override view returns (uint256 balance){
        return balances[_owner];
    }

    //Transferir cierta cantidad a otra cuenta

    /*
    Verificar que el monto que quiero transferir sea igual o menor que el balance del owner
    Actualizar el balance del owner 
    Actualizar el balance del buyer 
    Emitir un evento de tipo transfer
    Return si fue exitoso o no
    */
    function transfer(address _to, uint256 _value) external override returns (bool success){
        require (balances[msg.sender] <= _value);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //Que otra cuenta transfiera por ti. 
    /*
    Verificar que el remitente tenga menos o igual del valor que va a transferir. 
    Verificar que el monto sea menor o igual al pertido a gastar.
    Restar el valor a los balances del remitente. 
    Restar el valor a los balances de allowed. 
    Se le suma al destinatario el valor que le acaban de transferir
    Emitir el evento de tipo transfer
    Retorna true
    */
    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success){
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from] - _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    //Aprove. Permite gastar cierta cantidad de tokens a una address. 
    /*
    Actualizar balances del mapping allowed para permitir gastar cierto valor a una cuenta, a mi nombre.
    emitir evento Approval
    */
    function approve(address _spender, uint256 _value) external override returns (bool success){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //Allowance. Retornar la cantidad de tokens permitidos para una cuenta. 
    function allowance(address _owner, address _spender) external override view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }

}
