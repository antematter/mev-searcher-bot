// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract FrontRunMe {

    mapping (address => bytes32) public addressToSecret;

    // * Deposit and set a Secret
    function deposit(bytes32 _secret) public payable {
       addressToSecret[msg.sender] = _secret;
    }

    function withdraw(address _user, bytes32 _secret) public {

        // * Check if User knows the Password
        require(addressToSecret[_user] == _secret, "Wrong Password!");

        // * Send all Contract Balance to Caller
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
        
    }

    

}