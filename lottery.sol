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

    event BuyTokens(uint, address);
    
    //Constructor 
    constructor() public {
        token = new ERC20Basic(created_tokens);
        owner = msg.sender;
        thisContract = address(this);
    }

    // --------------------------------- TOKEN MANAGEMENT ---------------------------------------

    //Restrict to contract's owner 
    modifier OwnerOnly(address _address) {
        require(_address == owner, "This function is restricted to the contract's owner.");
        _;
    }
    
    //Get token price
    function GetTokenPrice(uint _numTokens) internal pure returns(uint){
        return _numTokens.mul(1 ether);
    }
    
    //Token creation
    function CreateTokens(uint _numTokens) public OwnerOnly(msg.sender){
        token.increaseTotalSupply(_numTokens);
    }

    //Buy tokens
    function BuyTokens(uint _numTokens) public payable{
        //Get contract's token balance
        uint balance = AvailableTokens();

        //Check availability of tokens
        require(_numTokens <= balance, "Not enough tokensavailable. Buy less tokens.");
        
        //get tokens price
        uint price = GetTokenPrice(_numTokens);

        //Check amount of eth payed
        require(msg.value >= price, "Buy less tokens or pay more ETH :)");

        //Refund change
        uint returnValue = msg.value.sub(price);
        msg.sender.transfer(returnValue);

        //Transfer tokens to buyer
        token.transfer(msg.sender, _numTokens);

        //Event
        emit BuyTokens(_numTokens, msg.sender);

    }

    //Get number of available tokens in contract
    function AvailableTokens() public view returns(uint){
        return token.balanceOf(thisContract);
    }

    //Get the balance of tokens in the lottery jackpot
    function Jackpot() public view returns(uint){
        return token.balanceOf(owner);
    }

    //Let participants know how many tokens they have
    function MyTokens() public view returns(uint){
        return token.balanceOf(msg.sender);
    }

    // --------------------------------- LOTTERY ---------------------------------------

    //Ticket price in tokens
    uint public ticketPrice = 5; 

    //Ticket numbers -> participants
    mapping(address => uint[]) idParticipantTickets;

    //Winner
    mapping(uint => address) winner;

    //Random number
    uint randNonce = 0;

    //Generated tickets
    uint[] tickets;

    //Events
    event buy_ticket(uint);
    event winner_ticket(uint);

    





}