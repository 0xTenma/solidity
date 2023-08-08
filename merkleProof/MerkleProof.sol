// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTest {
	bytes32 public root = 0x11...;
	
	function checkValidity(bytes32[] calldata _merkleProof) public view returns (bool) {
		bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
		require(MerkleProof.verify(_merkleProof, root, leaf), "Incorrect proof");
		return true; //Or you can mint tokens here

	}
}
