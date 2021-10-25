// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;

// Linkedin Example
contract Inheritance {
    address owner;
    bool deseased;
    uint money;

    constructor() public payable {
        owner = msg.sender;
        money = msg.value;
        deseased = false;
    }

    modifier oneOwner{
        require (msg.sender == owner);
        _;
    }

    modifier isDeseased {
        require (deseased == true);
        _;
    }

    address[] wallets;
    mapping (address => uint) inheritance;

    function setup(address _wallet, uint _inheritance) public oneOwner{
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
    }

    function moneyPaid() private isDeseased {
        for (uint i = 0; i < wallets.length; i++) {
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }

    function died() public oneOwner {
        deseased = true;
        moneyPaid();
    }
}
