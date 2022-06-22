//variables de entorno
require('dotenv').config()

//dependencias
const HDWalletProvider = require('@truffle/hdwallet-provider')
const ABI = require('./ABI')
const Web3 = require('web3');

//Inicializar nuestra wallet. Comunicarnos con la red.
async function getWalletProvider(){
    try {
        const provider = new HDWalletProvider({
            mnemonic : {
                phrase: process.env.MNEMONICS
            },
            providerOrUrl: process.env.PROVIDER,
        })
        return provider
    } catch(error) {
        console.log(error)
        return error
    }
}

//Instancia del contrato 
async function getContractInstance(provider,ABI, CONTRACT_ADDRESS){
    try{
        const web3 = new Web3(provider);
        const contract = new web3.eth.Contract(ABI, CONTRACT_ADDRESS);
        return contract;
    } catch(error){
        console.log(error);
        return error;
    }
}

async function getContractName(contract){
    try{
        let name = await contract.methods.name().call()
        return name
    } catch(error){
        console.log(error);
        return error
    }
}

async function main() {
    const provider = await getWalletProvider()
    const contract = await getContractInstance( provider, ABI, process.env.CONTRACT_ADDRESS)
    let name = await getContractName(contract) 
    console.log(name)
    //terminar el proceso
    process.exit(1)
}

main()