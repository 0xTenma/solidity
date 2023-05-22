// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Enum {
    enum Status {
        None, 
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() public view returns (Status) {
        return status;
    }
    
    function set(Status _status) external {
        status = _status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // back to default value
    }
}

contract CardDeck {
    enum Suit { Spades, Clubs, Diamonds, Hearts}
    enum Value {
        Two, Three, Four, Five, Six,
        Seven, Eight, Nine, Ten, 
        Jack, King, Queen, Ace
    }

    struct Card {
        Suit suit;
        Value value;
    }

    Card public myCard;

    function pickACard(Suit _suit, Value _value) public returns (Suit, Value) {
        myCard.suit = _suit;
        myCard.value = _value;

        return (myCard.suit, myCard.value);
    }
}