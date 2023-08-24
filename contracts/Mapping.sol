//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract Mapping{

    //mapping from address to uint
    //it always return value if value not set then return the default value
    //it is state variable
    mapping(address=>uint) public myMap;

    function get(address _addr)public view returns(uint){
        return myMap[_addr];  //in this way we will get id according to address
    }

    function set(address _addr, uint _i) public{
        myMap[_addr] = _i;
    }

    function remove(address _addr)public {
        delete myMap[_addr];
    }
}

contract NestedMapping{
    //address to other maaping
    mapping (address=> mapping(uint =>bool)) public nestedmap;

    function get(address _addr, uint _i) public view returns(bool){
        return nestedmap[_addr][_i];
    }

    function set(address _addr, uint _i, bool _boo) public{
        nestedmap[_addr][_i] = _boo;
    }

    function remove(address _addr, uint _i) public{
        delete nestedmap[_addr][_i];
    }
    


}


contract Array{
    uint[] public arr;
    uint[] public arr2 = [1,2,3];
    uint[10] public fixedsize; //fixed size array

    function get(uint i) public view returns(uint){
        return arr[i];
    }

    function getarray() public view returns(uint[] memory){
        return arr;
    }
    //Avoid to get entir arr
    function push(uint i) public{
        arr.push(i);
    }

    function pop() public{
        //remove last element
        arr.pop();
    }

    function remove(uint index) public{
        //not change array length
        delete arr[index];
    }

    //function examples() external{
        //create array in memory which can be of fix size only
       // uint[] memory arr = new uint[](5);
   // }
}

contract Enum{
    //enum represent shipping statis
    enum Status{
        Pending, Shipped,Aceept,Reject,Cancel
        
    }
    //default value if first element
    
//now Status is my own datatype
    Status public status; //refer enum

    //Returns uint
    //0 for pending, 1 for shipped, 2 for accepted

    function get() public view returns(Status){
        return status;
    }
 
    function set(Status _status) public{
        status = _status;
    }

    function cancel() public {
        status = Status.Cancel;
    }
    
    //delete reset enum to 0
    function reset() public{
        delete status;
    }
}


contract Todos{
    struct Todo{
        string textvar;
        bool completed;
    }

    //  array of struct
    Todo[] public todos;

    function create(string calldata _text) public {
       // todos.push(Todo(_text,false));
        todos.push(Todo({textvar: _text, completed:false})); //key value
    }
 
    function get(uint _index) public view returns(string memory text, bool completed){
        Todo storage todo=todos[_index];
        return(todo.textvar,todo.completed);
    }

    function updateText(uint _index, string calldata _text)public{
        Todo storage todo = todos[_index];
        todo.textvar=_text;
    }

    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }


}


contract Event{
    event Log(address indexed sender, string message); //declare
   

    function test() public{
        emit Log(msg.sender, "Hello"); //use
        emit Log(msg.sender, "Heloo maira");
    
    }
}


contract Counter{
    uint public count;

    function increment() external{
        count+=1;
    }
}

interface ICounter{
    function count() external view returns(uint);
    function increment() external;
}

contract Counter2{
    uint public count;
    function test(address addr) external {
        ICounter(addr).increment();
        count=ICounter(addr).count();

    }

  
}


contract Payable{

    address payable public owner;
    constructor() payable{
        owner =payable(msg.sender);
    }

    //Function to deposit ether in contract
    //Call this function along with some ether
    //The balance of contract will autoatically updated
    function deposit() public payable{}

    function notPayable() public{}


    //Function to withdraw ether
    function withdraw()  public {
        uint amount = address(this).balance;
        //send to owner he canreceive bcz his address is payable
        (bool success,) = owner.call{value:amount}("");
        require(success, "Failed to send ether");
    }

    //Function to tranfer ether from this contract to address given by user
    function transfer(address payable _to, uint _amount) public{
         //send to _to  canreceive bcz his address is payable
        (bool success,) = _to.call{value:_amount}("");
        require(success, "Failed to send ether");
    }
}

