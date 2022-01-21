//SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

import "./ERC20.sol";
import "./SafeMath.sol";

contract lottery{

    using SafeMath for uint;

    // --------------------------------- INITIAL DECLARATIONS ---------------------------------

    //Instance of token contract
    ERC20Basic private token;

    //Owner & contract address
    address payable public owner;
    address public thisContract;

    //Number of tokens
    uint public created_tokens = 700000;
    
    //Constructor 
    constructor() public {
        token = new ERC20Basic(created_tokens);
        owner = msg.sender;
        thisContract = address(this);
    }

    // --------------------------------- TOKEN MANAGEMENT ---------------------------------------

    //Token price
    function TokenPrice(uint _numTokens) internal pure returns(uint){
        return _numTokens.mul(1 ether);
    }
    
}