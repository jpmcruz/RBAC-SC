pragma solidity ^0.5.0;

contract RBACSC {
    
    mapping (address => User) public users;
    address[] public userAccounts;
    mapping (address => Endorse) public endorsees;
    address[] public endorseeAccounts; 
    Owner owner;
    uint public indexUser;
    uint public indexEndorsee;
    bool public status;
    
    constructor (string memory enterOrganizationName) public {
        owner.ownerAddress = msg.sender;
        owner.organizationName = enterOrganizationName;
        owner.dateCreated = block.timestamp;
        indexUser = 0;
        indexEndorsee = 0;
        status = true;
        addUser(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "a", "b");
        addUser(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, "d", "c");
    }
    
    struct Owner {
        address ownerAddress;
        string organizationName;
        uint dateCreated;
    }
    
    struct User {
        string userRole;
        string userNotes;
        uint userSince;
        uint userIndex;
    }
    
    struct Endorse {
        address endorser;
        string notes;
        uint endorseeSince;
        uint endorseeIndex;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner.ownerAddress, "Only the owner of smart contract can add users");
        _;
    }
    
    modifier onlyUsers {
        require(users[msg.sender].userSince != 0, "Only registered users can add/remove endorsees");
        _;
    }
    
    modifier contractActive {
        require(status == true, "Smart contract is not active");
        _;
    }
    
    //0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    //0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    function addUser(address _userAddress, string memory _userRole, string memory _userNotes) onlyOwner contractActive public {
        
        //  option 1
        //  User storage user = users[_userAddress];
        //  user.userAddress = _userAddress;
        //  user.userRole = _userRole;
        //  user.userNotes = _userNotes;
        //  user.userSince = block.timestamp;

        //  short way
        //  users[_userAddress] = User(__userRoleage, _userNotes, block.timestamp);
    
        //readable way
        require(users[_userAddress].userSince == 0, "User already exists");
        users[_userAddress] = User(
            {
                userRole: _userRole,
                userNotes: _userNotes,
                userSince: block.timestamp,
                userIndex: indexUser
            });
            userAccounts.push(_userAddress) -1;
            indexUser++;
    }
    
    function removeUser(address _userAddress) onlyOwner contractActive public {
        require(users[_userAddress].userSince != 0, "User does not exist");
        delete userAccounts[users[_userAddress].userIndex]; //delete address from userAccounts
        userAccounts[users[_userAddress].userIndex] = userAccounts[userAccounts.length - 1]; //copy last item to the just deleted address 
        User storage user = users[userAccounts[users[_userAddress].userIndex]]; //
        user.userIndex = users[_userAddress].userIndex; //update the userIndex of the corresponding User struct of moved item
        userAccounts.pop(); //remove the last item (same as the moved one)
        delete users[_userAddress]; //delete user from mapping
        indexUser--;
    }
    
    //0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    // 0x617F2E2fD72FD9D5503197092aC168c91465E7f2
    function addEndorsee(address _endorseeAddress, string memory _endorseeNotes) onlyUsers contractActive public {
        require(endorsees[_endorseeAddress].endorseeSince == 0, "Endorsee already exists");
        endorsees[_endorseeAddress] = Endorse(
            {
                endorser: msg.sender,
                notes: _endorseeNotes,
                endorseeSince: block.timestamp,
                endorseeIndex: indexEndorsee
            });
            endorseeAccounts.push(_endorseeAddress) -1;
            indexEndorsee++;
    }
    
    function removeEndorsee(address _endorseeAddress) onlyUsers contractActive public {
        require(endorsees[_endorseeAddress].endorseeSince != 0, "Endorsee does not exist");
        require(endorsees[_endorseeAddress].endorser == msg.sender, "Only the endorser can remove an endorsee");
        delete endorseeAccounts[endorsees[_endorseeAddress].endorseeIndex]; //delete address from userAccounts
        endorseeAccounts[endorsees[_endorseeAddress].endorseeIndex] = endorseeAccounts[endorseeAccounts.length - 1]; //copy last item to the just deleted address 
        Endorse storage endorsee = endorsees[endorseeAccounts[endorsees[_endorseeAddress].endorseeIndex]]; //
        endorsee.endorseeIndex = endorsees[_endorseeAddress].endorseeIndex; //update the userIndex of the corresponding User struct of moved item
        endorseeAccounts.pop(); //remove the last item (same as the moved one)
        delete endorsees[_endorseeAddress]; //delete user from mapping
        indexEndorsee--;
    }
    
    function changeStatus(bool _status) onlyOwner public {
       status = _status;
    }
    function getOwner() public view returns (address ownerAddress, string memory organizationName, uint dateCreated){
        return(owner.ownerAddress, owner.organizationName, owner.dateCreated);
    }
    
    function getUsers() public view returns (address[] memory){
        return userAccounts;
    }
    
    function getEndorsees() public view returns (address[] memory){
        return endorseeAccounts;
    }
    
    function getNoOfUsers() public view returns (uint){
        return userAccounts.length;
    }    
    
    function getNoOfEndorsees() public view returns (uint){
        return endorseeAccounts.length;
    }
    
    //same as built-in getter
    // function getUser(address _address) public view returns (string memory userRole, string memory userNotes, uint userSince, uint index){
    //      return(users[_address].userRole, users[_address].userNotes, users[_address].userSince, users[_address].userIndex);
    // }
}
