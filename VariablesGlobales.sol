// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract VariablesGlobales{

    //block

    uint public difficulty = block.difficulty;
    uint public number = block.number;

    //msg
    address public sender = msg.sender;
    uint public value = msg.value;

    //tx

    uint public txPrice = tx.gasprice;
}

//https://docs.soliditylang.org/en/v0.8.23/units-and-global-variables.html#special-variables-and-functions
