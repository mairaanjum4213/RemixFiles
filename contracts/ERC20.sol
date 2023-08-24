//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

interface IERC20{
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender)external view returns (uint256 remaining);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 
}

contract ZKToken is IERC20{
    string public name;
    string public symbol;
    uint public decimal;
    address public owner;
    mapping(address=>uint256) balances;
    mapping(address=>mapping(address=>uint256)) allowed;
    uint256 totalsupply = 1000 wei;

    constructor(string memory _name, string memory _symbol,uint _decimal){
        owner = msg.sender;
        balances[owner] = totalsupply;
        name=_name;
        symbol = _symbol;
        decimal=_decimal;
    }

    function totalSupply() public override view returns (uint256){
        return totalsupply;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(balances[msg.sender]>=_value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    modifier onlyOwner{
        require(msg.sender== owner, "Only owner can mint tokens");
        _;
    }

    function mint(uint8 _mintamount) public onlyOwner returns(uint256) {
        totalsupply += _mintamount;
        balances[msg.sender] += totalsupply;
        return totalsupply;
    }

    function burn(uint8 _burnamount) public onlyOwner returns(uint256) {
        require(balances[msg.sender] >= _burnamount , "You have insufficient tokens");
        totalsupply -= _burnamount;
        balances[msg.sender] -= totalsupply;
        return totalsupply;
    }

    //set value for spender
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender, _value);
        return true;
    }


    //Return HOW remaining  spender can spend
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }

    //function when you want to send token from some other's wallet run by spender
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        uint256 allowance1 = allowed[_from][msg.sender]; //msg.sender is spender
        require(balances[_from] >= _value && allowance1 >= _value);
        balances[_to] += _value;
        balances[_from] -=  _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from , _to, _value);
        return true;
    }

}