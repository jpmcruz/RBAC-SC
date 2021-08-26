pragma solidity ^0.8.0;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract RBACSC is Ownable, AccessControl {

    mapping (address => UserStruct) public usersAll;
    address[] public userAccounts;
    mapping (address => EndorseStruct) public endorseesAll;
    address[] public endorseeAccounts;
    OwnerStruct public ownerdetails;
    uint public indexUser;
    uint public indexEndorsee;
    bool public status;
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");
//    bytes32 public constant ENDORSEE_ROLE = keccak256("ENDORSEE_ROLE");

    constructor (string memory enterOrganizationName) public {
        ownerdetails.ownerAddress = msg.sender;
        ownerdetails.organizationName = enterOrganizationName;
        ownerdetails.dateCreated = block.timestamp;
        indexUser = 0;
        indexEndorsee = 0;
        status = true;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender); //give owner of the contract (organization) the admin role which can grant roles.
        addUser(0x98c3327531eB76995D120bA027e46D35Ed79dbf1, "a", "b"); //for testing purposes only, remove when deploying
        addUser(0xF209e4a4b23Ca181eF9aB9f247793e1173b23634, "d", "c"); //for testing purposes only, remove when deploying
    }

    struct OwnerStruct {
        address ownerAddress;
        string organizationName;
        uint dateCreated;
    }

    struct UserStruct {
        string userRole;
        string userNotes;
        uint userSince;
        uint userIndex;
    }

    struct EndorseStruct {
        address endorser;
        string notes;
        uint endorseeSince;
        uint endorseeIndex;
    }

    modifier contractActive {
        require(status == true, "Smart contract is not active");
        _;
    }

    function addUser(address _userAddress, string memory _userRole, string memory _userNotes) public onlyOwner contractActive {

        //  option 1
        //  User storage user = users[_userAddress];
        //  user.userAddress = _userAddress;
        //  user.userRole = _userRole;
        //  user.userNotes = _userNotes;
        //  user.userSince = block.timestamp;

        //  short way
        //  users[_userAddress] = User(__userRoleage, _userNotes, block.timestamp);

        //readable way
        require(usersAll[_userAddress].userSince == 0, "User already exists");
        usersAll[_userAddress] = UserStruct(
            {
                userRole: _userRole,
                userNotes: _userNotes,
                userSince: block.timestamp,
                userIndex: indexUser
            });
        userAccounts.push(_userAddress);
        indexUser++;
        grantRole(USER_ROLE, _userAddress);
    }

    function removeUser(address _userAddress) public onlyOwner contractActive {
        require(usersAll[_userAddress].userSince != 0, "User does not exist");
        delete userAccounts[usersAll[_userAddress].userIndex]; //delete address from userAccounts
        userAccounts[usersAll[_userAddress].userIndex] = userAccounts[userAccounts.length - 1]; //copy last item to the just deleted address
        UserStruct storage user = usersAll[userAccounts[usersAll[_userAddress].userIndex]]; //
        user.userIndex = usersAll[_userAddress].userIndex; //update the userIndex of the corresponding User struct of moved item
        userAccounts.pop(); //remove the last item (same as the moved one)
        delete usersAll[_userAddress]; //delete user from mapping
        indexUser--;
        revokeRole(USER_ROLE, _userAddress);
    }

    function addEndorsee(address _endorseeAddress, string memory _endorseeNotes) public contractActive onlyRole(USER_ROLE) {
      //  require(hasRole(USER_ROLE, msg.sender), "Caller does not have the USER role");
        require(endorseesAll[_endorseeAddress].endorseeSince == 0, "Endorsee already exists");
        endorseesAll[_endorseeAddress] = EndorseStruct(
            {
                endorser: msg.sender,
                notes: _endorseeNotes,
                endorseeSince: block.timestamp,
                endorseeIndex: indexEndorsee
            });
            endorseeAccounts.push(_endorseeAddress);
            indexEndorsee++;
    }

    function removeEndorsee(address _endorseeAddress) public contractActive {
        require(endorseesAll[_endorseeAddress].endorseeSince != 0, "Endorsee does not exist");
        require(endorseesAll[_endorseeAddress].endorser == msg.sender, "Only the endorser can remove an endorsee");
        delete endorseeAccounts[endorseesAll[_endorseeAddress].endorseeIndex]; //delete address from userAccounts
        endorseeAccounts[endorseesAll[_endorseeAddress].endorseeIndex] = endorseeAccounts[endorseeAccounts.length - 1]; //copy last item to the just deleted address
        EndorseStruct storage endorsee = endorseesAll[endorseeAccounts[endorseesAll[_endorseeAddress].endorseeIndex]]; //
        endorsee.endorseeIndex = endorseesAll[_endorseeAddress].endorseeIndex; //update the userIndex of the corresponding User struct of moved item
        endorseeAccounts.pop(); //remove the last item (same as the moved one)
        delete endorseesAll[_endorseeAddress]; //delete user from mapping
        indexEndorsee--;
    }

    function changeStatus(bool _status) public onlyOwner {
       status = _status;
    }
    function getOwner() public view returns (address ownerAddress, string memory organizationName, uint dateCreated){
        return(ownerdetails.ownerAddress, ownerdetails.organizationName, ownerdetails.dateCreated);
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
}
