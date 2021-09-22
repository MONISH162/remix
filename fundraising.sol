pragma solidity ^0.4.11;
contract CrowdFunding {
        struct FundingProject {
        
        string name;
        string email;
        string website;
        uint minimumfunds;
        uint amountraised;
        address owner;
        string status;
      
    }
    
    //Funder who funds project.
    struct Funder {
        string name;
        address fundedby;
        uint amount;}
    

Funder[] public funders;
    
    //Instance
    FundingProject public fundingproject;
    function CrowdFunding (        
        string _name,
        string _email,
        string _website,
        uint _minimumfunds,
        address _owner        
        )
    {
       	
 //convert to ether
uint minimumfunds = _minimumfunds * 1 ether;
uint amountraised = 0;
fundingproject = 
FundingProject(_name,_email,_website,
minimumfunds,amountraised,_owner,
"Funding Started");
       
    }
    function fundProject( string name) public payable {

if (stringsEqual(fundingproject.status ,"Funding Completed")) revert();
	funders.push(Funder({
				name: name,
				fundedby: msg.sender,
				amount: msg.value
			   }) 
			);
	 fundingproject.amountraised =	    
                fundingproject.amountraised + msg.value ;

if (fundingproject.amountraised >= 
               fundingproject.minimumfunds) {
				                 
              if(!fundingproject.owner.send(fundingproject.amountraised )) revert();				 
               fundingproject.status = "Funding Completed";
	} 
	else {		   			
                         fundingproject.status = "In Progress";
	}
}
function  stopFundRaising() public payable {
    	 if (stringsEqual(fundingproject.status ,"Funding Completed")) revert();
    	 fundingproject.status = "Funding Stopped";
    	 //return money to all funders
    	 for (uint p = 0; p < funders.length; p++) {
    	 	if(!funders[p].fundedby.send(funders[p].amount)) throw;
    	 }
    	 fundingproject.amountraised = 0;
    }
    function getProjectStatus() public constant	returns(string) {
    		return (fundingproject.status);
}
}