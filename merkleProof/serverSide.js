import "index.js";

let address = addresses[0]

let hashedAddress = keccak256(address)
let proof = merkleTree.getHexProof(hashedAddress)

console.log(proof)

let v = merkleTree.verify(proof, hashedAddress, rootHash)
console.log(v) // returns true
