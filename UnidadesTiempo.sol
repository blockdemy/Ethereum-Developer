// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract UnidadesTiempo{

   uint public oneSecond = 1 seconds;
   uint public oneMinute = 60 seconds;
   uint public oneHour = 60 minutes;
   uint public oneDay = 24 hours;
   uint public oneWeek = 7 days;
   
   bool public prueba1 = oneMinute == oneSecond*60; 
   bool public prueba2 = oneWeek == oneDay*7; 
    
}
