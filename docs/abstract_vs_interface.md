Extensibility is key when it comes to build larger, more complex distributed applications(dapps). Solidity offers two ways to facilitate this in dapps.


>Interface only declares functions. Can't implement them.

    interface IMyContract {
        function foo() external returns (bool);
    }

Interfaces are most useful when it comes to designing larger scale dapps prior to their comprehensive implementations. They make it easy to facilitate extensibility in dapps without introducting added complexity.
Many of their built in contraints are what can ultimately be used to inform your decision as to whether or not to use an interface instead of an abstract contract. 

>Abstract class can declare functions as well as implement them.

    abstract contract MyContract {
        function foo() virtual external returns (bool);

        function hello() external pure returns (uint8) {
            return 1;
        }
    }

Abstract contracts are particularly useful when we install patterns. They give the ability to implement most of a contract yet you can still include abstract functions in it in order to define and self document the skeleton of dapp. Doing so facilitates extensibility, removes code duplication and reduces overhead when you have multiple contracts that need to communicate with one another.

>Both can't be instantiated and need to be implemented/inherited from.

