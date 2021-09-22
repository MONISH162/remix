pragma solidity ^0.5.11;
contract Simple{
function calcuate(uint256 _value) public view returns(string memory) {
    _value=9;
 if(_value%2==0) {
 return "even";
 } else {
 return "odd"; 
 }
 }
}