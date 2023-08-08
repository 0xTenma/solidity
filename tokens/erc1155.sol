// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC1155 {
    function safeTransferFrom (
        address from,
        address to, 
        uint256 id,
        uint256 value,
        bytes calldata data
     ) external ;

    function safeBatchTransferFrom (
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external ;

    function balanceOf(address owner, uint256 id) external view returns (uint256);

    function balanceOfBatch(address[] calldata owners, uint256[] calldata ids) external view returns (uint256[] memory);

    function setApprovalForAll(address operator, bool approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

interface IERC1155TokenReceiver {
    function onERC1155Received (
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
     ) external returns (bytes4);

    function onERC1155BatchReceived (
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}

contract ERC1155 is IERC1155 {
    event TransferSingle (
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 value
    );

    event TransferBatch (
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    event ApprovalForAll (
        address indexed owner,
        address indexed operator,
        bool approved
    );

    event URI (
        string value,
        uint256 indexed id
    );

    mapping(address => mapping(uint256 => uint256)) public balanceOf;
    mapping(address => mapping(address => bool)) public isApprovalForAll;

    function balanceOfBatch(address[] calldata owners, uint256[] calldata ids)
        external 
        view 
        returns (uint256[] memory balances) 
        {
        require(owners.length == ids.length, "Owners length != ids length");
        balances = new uint[](owners.length);

        unchecked {
            for(uint256 i = 0; i < owners.length; i++) {
                balances[i] = balanceOf[owners[i][ids][i]];
            }
        }
    }

    function setApprovalForAll (address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function safeTransferFrom (
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external {
        require(
            msg.sender == from || isApprovedForAll[from][msg.sender], 
            "not approved"
        );

        require(to != address(0), "to = address(0)");
        
    }
}
