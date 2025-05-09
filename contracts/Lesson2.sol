// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Lesson2 {
    struct Product {
        string name;
        string description;
        address creator;
        uint timestamp;
        string imageUrl;
    }
    Product[] products;

    function getProducts() public view returns(Product[] memory) {
        return products;
    }

    function addProduct(string memory name, string memory description, string memory imageUrl) public {
        Product memory product = Product(name, description, msg.sender, block.timestamp, imageUrl);
        products.push(product);
    }
}
