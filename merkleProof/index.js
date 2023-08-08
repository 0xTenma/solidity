const {MerkleTree} = require("merkletreejs")
const keccak256 = require("keccak256")

let addresses = [
	"0xAbCDeF1234567890AbCDeF1234567890AbCDeF12",
	"0x0123456789AbCDeF0123456789AbCDeF01234567",
	"0xAbCdEfAbCdEfAbCdEfAbCdEfAbCdEfAbCdEfAbCdE",
	"0x9876543210abcdefABCDEF9876543210abcdefAB",
	"0x1234567890ABCDEFabcdef1234567890ABCDEFab"
	]

// hash addresses to get the leaves
let leaves = addresses.map(addr => keccak256(addr))

// create tree
let mekleTree = new MerkleTree(leaves, keccak256, {sortPairs: true})

// get root
let rootHash = merkleTree.getRoot().toString('hex')

// print the tree
console.log(merkleTree.toString())

