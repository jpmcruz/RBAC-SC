# RBAC-SC
Solidity Code for the RBAC-SC smart contract

RBACSC.sol is the latest version of the code.

Compile the file (e.g., use RemixIDE).

When deploying to a blockchain (e.g., testnet), input the name of the organization as defined in the constructor.

The account used for deploying the smart contract is the Owner.

Only owner has the ability to add/remove users.
Only users have the ability to add/remove endorsees.

Tested on Ropsten:
Deploy with "MyOrg" name.
Transaction details: https://ropsten.etherscan.io/tx/0x16de55762bc314a4adb1de212b38614d4b652e328a2f355a085b366d3d85d4ee
Contract address: 0x16de55762bc314a4adb1de212b38614d4b652e328a2f355a085b366d3d85d4ee
Tx hash: 0x16de55762bc314a4adb1de212b38614d4b652e328a2f355a085b366d3d85d4ee

Owner Adds 0xde0d9E4Bbd5d4b2F0BfB6b05eA61348f8085D74f (User1), Professor, Expiry: March 2022
Tx hash: 0xa03211c05354a86773d84ae49bb21004f5f5f51855537040d30c2efd39b3b514

Owner Adds 0xe49501eBD73f52C3e6CA3166e96eb7e548654e00 (User2), Student, Expiry: March 2023
Tx hash: 0x4b762eab2cd3d3ff2f3a366def430d2901717032fa6697f804fc0055cbd025db

User1 adds 0x50C6097036ec1918493B032b5aEdFA2FA6694a16 (Endorsee 1), Visiting Researcher, Expiry: October 2021
Tx hash: 0x0423c6a87fab341ccf3afebc3e7132fe8e952a57a226d9638a133fa9add4d9a3

Owner removes User2.
Tx hash:0x2c766cac88c5f68f89377fa106b2e6ae2c709a7c7c50589fad73ce4112041e62

User1 removes Endorsee1.
Tx hash:0xca9f9eff629fc0a25ad407a8ffdbfcdce0a7166fe1648a6524eb8a7b972bb94a

Note: Published on ipfs.
Metadata of "rbacsc" was published successfully.
@openzeppelin/contracts/access/AccessControl.sol :
ipfs://QmYoFrDD2c6fi9CpPz1bjCMAyketjZ3G7ByUSVQMntysms
@openzeppelin/contracts/access/IAccessControl.sol :
ipfs://QmTxDshRAMtoeM45YrTzQZdpmy4mt4scCNHjfZiWSvdETF
@openzeppelin/contracts/access/Ownable.sol :
ipfs://Qmd5c7Vxtis9wzkDNhxwc6A2QT5H9xn9kfjhx7qx44vpro
@openzeppelin/contracts/utils/Context.sol :
ipfs://QmWcsmkVr24xmmjfnBQZoemFniXjj3vwT78Cz6uqZW1Hux
@openzeppelin/contracts/utils/Strings.sol :
ipfs://QmQwCB2BHnEuYR22PYt9HkpbgeFDhq4rHmaYqAZbX3WRC7
@openzeppelin/contracts/utils/introspection/ERC165.sol :
ipfs://Qmejonoaj5MLekPus229rJQHcC6E9dz2xorjHJR84fMfmn
@openzeppelin/contracts/utils/introspection/IERC165.sol :
ipfs://QmcsVgLgzWdor3UnAztUkXKNGcysm1MPneWksF72AvnwBx
RBAC-SC.sol :
ipfs://QmaR6YtS1KsFiBpUGFGezmFKDiExDzex7ML8KhhuY3n8QE
metadata.json :
ipfs://QmS2fVqGGUBANad1QNDdtt2xZ4pq3GJCTdBU5YYdjz9uwc
