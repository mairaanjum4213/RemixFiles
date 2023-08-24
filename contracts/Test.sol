//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Test{
    uint256  numberOfTickets;
    uint256  ticketPrice;
    uint256  totalAmount;
    uint256 startAt;
    uint256 endAt;
    uint256  timeRange;
    string  str = "buy your first ticket";

    constructor(uint256 _ticketprice){
        ticketPrice =_ticketprice;
        startAt = block.timestamp;
        endAt = block.timestamp+7 days; //User can buy ticket for 7 days after deployment
        timeRange = (endAt-startAt) /60 /60 /24;

    }

    function buytickets(uint256 _value) public returns (uint256 ticketid){
        numberOfTickets++;
        totalAmount += _value;
        ticketid= numberOfTickets;

    }

    function getinfo() public view returns(uint256){
        return totalAmount;
    }
}
