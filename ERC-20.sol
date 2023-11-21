// SPDX-License-Identifier: UNLICENSED;
pragma solidity 0.8.0;

interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external pure returns (uint8);
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
    string private _name;

    //SIMBOLO
    string private _symbol;

    // DECIMALES
    uint8 private _decimals;

    //TOTAL SUPPLY
    // 10 ether ===> 10 000000000000000000
    uint256 private _totalSupply;


    //BALANCES
    mapping (address => uint256) private _balances;

    //ALLOWED - Address del propietario - Address del spender autorizado
    mapping(address => mapping (address => uint256)) private _allowed;

    constructor(){
        _name = "Blockdemy Token";
        _symbol = "BAM Token";
        _totalSupply = 20 ether; 
        _balances[msg.sender] = _totalSupply;
    }

    //Funciones

    function name() public view override returns (string memory){
        return _name;
    }

    function symbol() public view override returns (string memory){
        return _symbol;
    }

    function decimals() public pure override returns (uint8){
        return 18;
    }
    
    //TotalSupply retorna el total supply
    function totalSupply() external override view returns (uint256){
        return _totalSupply;
    }

    //Devolver el balance de una cuenta en especifico.
    function balanceOf(address _owner) external override view returns (uint256 balance){
        return _balances[_owner];
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
        require (_balances[msg.sender] >= _value);
        _balances[msg.sender] = _balances[msg.sender] - _value;
        _balances[_to] = _balances[_to] + _value;
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
        require(_value <= _balances[_from]);
        require(_value <= _allowed[_from][msg.sender]);
        _balances[_from] = _balances[_from] - _value;
        _allowed[_from][msg.sender] = _allowed[_from][msg.sender] - _value;
        _balances[_to] = _balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    //Aprove. Permite gastar cierta cantidad de tokens a una address. 
    /*
    Actualizar balances del mapping allowed para permitir gastar cierto valor a una cuenta, a mi nombre.
    emitir evento Approval
    */
    function approve(address _spender, uint256 _value) external override returns (bool success){
        _allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //Allowance. Retornar la cantidad de tokens permitidos para una cuenta. 
    function allowance(address _owner, address _spender) external override view returns (uint256 remaining){
        return _allowed[_owner][_spender];
    }

}
//Owner
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

//Receiver
//0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

//Spender
//0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
