pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";

contract CBKMint is Ownable {

    IKIP17Enumerable public nft;

    constructor(IKIP17Enumerable _nft) public {
        nft = _nft;
    }

    function mint(address to, uint256 count) payable external {
        require(msg.value == count * 20 ether);
        uint256 balance = nft.balanceOf(address(this));
        require(count <= balance);
        for (uint256 i = 0; i < count; i += 1) {
            nft.transferFrom(address(this), to, nft.tokenOfOwnerByIndex(address(this), i));
        }
        owner().transfer(msg.value);
    }
}
