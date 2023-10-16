// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol"

interface IERC721 {
    function transferFrom(address _from, address _to, uint _id) external {}
}

contract Escrow {
   
    address public payable seller;
   
    address public lender;

    using SafeMath for uint;

// amount deposited in each account

    mapping (address => uint) deposits;

    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }
    constructor(address _inspector, address _nftAddress, address _lender ) public {
        inspector=_inspector;
        nftAddress=_nftAddress;
        seller=msg.sender;
        lender=_lender;
    }

    function deposit(address lender) payable public onlySeller{
        uint amount = msg.value;
        deposit[lender]= msg.value.add(amount);
    }

    function withdraw(address payable lender) payable public onlySeller{
        uint amount = deposit[lender];
        deposit[lender] = 0;
        lender.transfer(payament);
    }
}
