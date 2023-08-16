//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Number{
    uint256 num;
    string name = "maira";
    function getnum() public view returns(uint256){
        return num;
    }
    
    function getname() public view returns(string memory){
        return name;
    }

    function changenum(uint256 _num) public returns(uint256){
        num=_num;
        return num;
    }
}