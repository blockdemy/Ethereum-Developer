// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract SendEther{
    //transfer()
    function sendEtherTransfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }
    
    //send()
    function sendEtherSend(address payable _to) public payable returns(bool sent){
        sent = _to.send(msg.value);
    }

    //call()
    function sendEtherCall(address payable _to) public payable returns(bool sent, bytes memory data){
        (sent,data) = _to.call{value: msg.value}("");

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
    //getBalance()
}
