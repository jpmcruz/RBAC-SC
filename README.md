# RBAC-SC
Solidity Code for the RBAC-SC smart contract

RBACSC.sol is the latest version of the code. 

Compile the file (e.g., use RemixIDE).

When deploying to a blockchain (e.g., testnet), input the name of the organization as defined in the constructor.

The account used for deploying the smart contract is the Owner. 

Only owner has the ability to add/remove users. 
Only users have the ability to add/remove endorsees.

Tested on Ropsten:
Deploy with "Org1" name.
Contract address: https://ropsten.etherscan.io/address/0xe34ae25229287f65cbe98dc9828e1442a9227d43
Tx hash: 0xeea3862402ae992d9e002d9d21b0b7bccb8495859d65d564fef5bea0a631e1b4

Owner Adds 0xde0d9E4Bbd5d4b2F0BfB6b05eA61348f8085D74f (User1), Professor, Expiry: March 2022
Tx hash: 0xdcad4391c8a149a30926dd25b1291f973fc634711259089176f023a28319dc11

Owner Adds 0xe49501eBD73f52C3e6CA3166e96eb7e548654e00 (User2), Student, Expiry: March 2023
Tx hash: 0x29dfcc0466bc3f94b93161c1eb8c10081393d1ab955617ab004844fe276bfc71

User1 adds 0x50C6097036ec1918493B032b5aEdFA2FA6694a16 (Endorsee 1), Visiting Researcher, Expiry: October 2021
Tx hash: 0xa3baa438c7fffab12407b3efaef6dff78ac7b6f94594a5a3809d601d3fa96d4e

Owner removes User2.
Tx hash:0x02ce2ca841dbf97f00bf809328179cb233c672aca69343bdadbf8eca6cab4a05

User1 removes Endorsee1.
Tx hash:0x6768045900d339ba77b56d30308badb808160dcbf08eaf698efb1a386d5b48a6

TODO: Add the update of accounts capability.
