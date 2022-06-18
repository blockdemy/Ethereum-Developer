//SPDX-License-Identifier: UNLICENSED;
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

    // VARIABLES
        // NOMBRE
        string public constant name = "Blockdemy Community Token";
        //SIMBOLO
        string public constant symbol = "BAM";
        // DECIMALES
        uint8 public constant decimals = 18;


        mapping (address => uint256) balances;
        mapping(address => mapping (address => uint256)) allowed;

        // 10 ether ===> 10 000000000000000000
        uint256 totalSupply_ = 10 ether;
    // CONSTRUCTor

    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    // FUNCIONES

    // totalSupply retornar total supply
    function totalSupply() public override view returns (uint256){
        return totalSupply_;
    }
    // balanceOf devolver el balance de una cuenta en especifico
    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }
    // transfer transferir de una cuenta a otra
    /*
        VERIFICAR QUE EL MONTO SEÑALADO SEA IGUAL O MENOR QUE EL BALANCE DEL OWNER
        ACTUALIZAR BALANCE DEL OWNER
        ACTUALIZAR BALANCE DEL BUYER
        EMITIR UN EVENTO DE TIPO TRANSFER
        RETORNAR ALGO ***


    */
    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    // transferFrom transferir de una cuenta  a la cual se le permitio gastar lso tokens del owner
            /*
        
            VERIFICAR QUE EL MONTO SEÑALADO SEA IGUAL O MENOR QUE EL BALANCE DEL OWNER
            VERIFICAR EL MONTO SEÑALADO SEA IGUAL O MENOR QUE LOS PERMITIDOS A GASTAR POR EL SPENDER
            ACTUALIZAR BALANCE DEL OWNER
            ACTUALIZAR EL BALANCE DEL SPENDER
            ACTUALIZAR BALANCE DEL BUYER

            EMITIR UN EVENTO DE TIPO TRANSFER
            RETORNAR TRUE
        

    */

    function transferFrom(address _owner, address _buyer, uint256 _value) public override returns (bool success){
        require(_value <= balances[_owner]);
        require(_value <= allowed[_owner][msg.sender]);
        balances[_owner] = balances[_owner] - _value;
        allowed[_owner][msg.sender] = allowed[_owner][msg.sender] - _value;
        balances[_buyer] = balances[_buyer] + _value;
        emit Transfer(_owner, _buyer, _value);
        return true;
    }
    // approve es permitir gastar cierta cantidad de tokens a una address en especifica
    /*
        actualizar los balances del mapping allowed par apermitir gastar cierta cantidad de tokens
        emitir tipo Approval
        retornar true
    */
    function approve(address _spender, uint256 _value) public override returns (bool success){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    // allowance retornar la cantidad de tokens permitidos para gastar de un owner
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}

