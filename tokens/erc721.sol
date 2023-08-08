// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC165 {
    function supportInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint balance);

    function ownerOf(uint tokenID) external view returns (uint owner);

    function safeTransferFrom(
        address from, 
        address to, 
        uint tokenId
    ) external ;

    function transferFrom(
        address from, 
        address to,
        uint tokenId
    ) external;

    function approve(address to, uint tokenId) external;

    function getApprove(uint tokenId) external view returns (address operator);

    function setApproveForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract ERC721 is IERC721 {
    event Transfer(address indexed from, address indexed to, uint indexed id);
    event Approval(address indexed owner, address indexed spender, uint indexed id);
    event ApprovalForAll(
        address indexed owner, 
        address indexed operator, 
        bool approved
    );

    // uint id and address of owner
    mapping(uint => address) internal _onwerOf;
    // address will account and uint will be nft count owned by the account
    mapping(address => uint) internal _balanceOf;
    // id of ntf to address that was given approval to spend the nft
    mapping(uint => address) internal _approvals;
    // owner owns many nft then we give permission to single address
    mapping(address => mapping(address => bool)) public isApprovalForAll;

    function supportInterface(bytes4 interfaceID) external view returns (bool) {
        return interfaceID == type(IERC721).interfaceId || interfaceID == type(IERC165).interfaceId;
    }

}