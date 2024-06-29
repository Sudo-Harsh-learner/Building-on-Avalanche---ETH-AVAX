// SPDX-License-Identifier: MIT
pragma solidity >0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    address private owner;
    string[3] private items = ["Car","Bike","Shoes"];
    uint[3] private prices = [1000, 500, 100];
    mapping(address => string[]) private ownedAssets;
    constructor() ERC20("Degen", "DGN"){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner==msg.sender,"Only owner has access");
        _;
    }

    function mintTo(address _to,uint _val) public onlyOwner{
        _mint(_to,_val);
    }

    function burnFrom(uint _val) public {
        _burn(msg.sender, _val);
    }

    function redeem(uint _item) public {

        require(_item-1 < items.length && _item-1 >= 0, "Item index out of bounds");
        uint price = prices[_item-1];
        _burn(msg.sender, price);
         ownedAssets[msg.sender].push(items[_item - 1]);
    }

    function transferTo(address _to, uint _val) public  {
        _transfer(msg.sender, _to, _val);
    }

    function getOwnedAssets(address _owner) public view returns (string[] memory) {
        return ownedAssets[_owner];
    }

    
}
