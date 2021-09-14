pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";

contract CBKMint is Ownable {

    IKIP17Enumerable public nft;

    constructor(IKIP17Enumerable _nft) public {
        nft = _nft;
    }

    function mint(uint256 id) payable external {
        require(msg.value == 20 ether);
        nft.transferFrom(address(this), msg.sender, id);
        owner().transfer(msg.value);
    }
}
