//SPDX-License-identifier: UNLICENSED

pragma solidity 0.8.10;

contract VoteClass{


    //Storage - Lo que se va a almacenar

    //Variables

    //Datos del votante
    //struct - guarda diferentes tipos de datos primitivos
    struct voter{

        //voto o no 
        bool voted; 

        //index candidato a votar - unsigned 
        uint256 candidateIndex; 

        //Puede o no votar
        bool canVote;   
    }

    //Diccionarios de votantes
    //{0x5CF66B335648b9226Da573699dfc28382bBFdf5e,Lizeth}, {2,Medea}, {3,Armando}
    mapping (address => voter) public voters;


    //Datos del candidato
    struct candidate{

        //nombre candidato
        bytes32 name; 

        //num de votos
        uint32 voteCount;
    }

    //Arreglo de candidatos
    candidate[2] public candidates;

    //address del admin
    address public admin; 

    //COnocer si la votación está activa o no 
    bool public isActive = true;     
    

    //Constructor 
    constructor (){
        bytes32 candidateOne = "Santiago"; 
        bytes32 candidateTwo = "Pablo";//En bytes: 5061626c6f

        //La dirección que haga deploy del contrato, será el admin.
        admin = msg.sender;

        //Agregar los candidatos
        candidates[0] = candidate({
            name: candidateOne,
            voteCount : 0 
        });

        candidates[1] = candidate({
            name: candidateTwo,
            voteCount : 0 
        });
    }

    //Events
    event Vote(bytes32 indexed _candidate); 

    //Funciones
    //Función de votar
    function vote(uint256 _candidateVote) external{
        //instanciar al votante
        voter storage sender = voters[msg.sender];
        
        //Si la votación estpa activa, vota
        require(isActive, "Ya se cerro la votacion");

        //Si puede o no votar
        require(sender.canVote, "You cannot vote");

        //Si vota por un index de candidato que no sea posible
        require(_candidateVote < 2, "Invalid vote");

        //Si ya votó
        require(!sender.voted, "Already voted" );

        //Sumar el voto al candidato
        candidates[_candidateVote].voteCount++;

        //Que ya no pueda votar
        sender.voted = true;

        //Si un candidato tiene más de 2 votos, finaliza la votación 
        if(candidates[_candidateVote].voteCount > 2 ){
            finishVote();
        }

    }

    //Modifiers - Quien puede acceder o hacer a cierta función 
    modifier onlyAdmin{
         //Admin de el derecho a votar 
        require(msg.sender == admin, "only admin allow"); 
        _; 
    }

    function giveRightVote(address _voter) external onlyAdmin{
        
        //Revisar si no ha votado 
        require(!voters[_voter].voted, "Already vote");

        //Cambia su status a puede votar
        voters[_voter].canVote = true;
    }



    //Finalizar el uso del contract para que puedan votar 

    function finishVote() internal  {
        isActive = false;
    }

    //Consultar el candidato ganador
    function getWinningName() public view returns(bytes32){
       
        require(!isActive, "Still Active");

       if (candidates[0].voteCount > candidates[1].voteCount){
                return candidates[0].name;
            }else{
                return candidates[1].name;
            }

        }    
        /*
        bool active = true;
        if(active == true) -> if(active)
        if(active == false) -> if(!active)
        */
        
       /*
        if(!isActive){
            if (candidates[0].voteCount > candidates[1].voteCount){
                return candidates[0].name;
            }else{
                return candidates[1].name;
            }
        }
        */
}




/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
0x617F2E2fD72FD9D5503197092aC168c91465E7f2
0xdD870fA1b7C4700F2BD7f44238821C26f7392148


*/
