// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
0. message to sign 
1. hash(message)
2. sign(hash(message)), private key) | offchain
3. ecrecover(hash(message), signature) == signer

*/

contract VegSig {
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        return keccak256(abi.encdoePacked(_to, _amount, _message, _nonce));
    }

    function getEthSignedMessageHash(string memory _messageHash) public pure returns (bytes32){
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message: \n32",
            _messageHash
        ));
    }

    function recover(bytes32 _ehtSignedMessageHash, bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        ecrecover(_ehtSignedMessageHash, v, r, s);
    }

}