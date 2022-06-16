// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

pragma solidity >=0.7.0 <0.9.0;

contract _GoFundMe {
string [] eventList;
address owner ;
mapping(string => address ) donation ;
mapping(address=> uint) public initialBalance;
mapping(string => uint) neededAmount ;
mapping (string=> string) description;
address[] donorList;

 
constructor(){
    owner = msg.sender;
}
 function AddEvent (string memory titleOfEvent,uint amount,string memory _description) public {
      for(uint i=0;i<eventList.length;i++){
          require(keccak256(abi.encodePacked(titleOfEvent) )!= keccak256(abi.encodePacked(eventList[i])),
          "The funding event you are trying to add already exists");
      }
      eventList.push(titleOfEvent);
      neededAmount[titleOfEvent]= amount;
      donation[titleOfEvent]=msg.sender;
      initialBalance[msg.sender]= msg.sender.balance;
      description[titleOfEvent] = _description;
     
 }

 function ShowList () public  view returns(string[]memory){
  return eventList;  // show projects available to donate
  
 }
 function getNeededAmount( string memory Event) public view returns (uint){
    return neededAmount[Event];  // show how much funding a spesific project needs 
 }
 function donate(string memory Event) public payable{
      require(checkIfFoundingGoalReached(Event)==false,
      "Funding goal of this project has already been reached");
      payable(donation[Event]).transfer(msg.value);
      donorList.push(msg.sender);       // donate eth to a project 
      
 } 
 function checkIfFoundingGoalReached (string memory Event) public view returns(bool) { // checks if funding goal reached
      bool isFoundingGoalReached = false;
      uint amount = neededAmount[Event];
      address victimAdress = donation[Event];
      uint initial_balance=initialBalance[victimAdress];
      uint  weiAmount=amount* 1000000000000000000;
     uint goal = initial_balance+ weiAmount;
      if(donation[Event].balance== goal){
          isFoundingGoalReached = true;
      }
      return isFoundingGoalReached;
 } 
 function returnDonorList () public view returns (address[] memory){ // returns the people who contributed to a project 
     require(donorList.length!=0,"Nobody has donated anything yet");
     return donorList;
 }
function ShowEventDescription (string memory EventName) public view returns (string memory){
   return description[EventName];  // show the description of a project 
 
}
}