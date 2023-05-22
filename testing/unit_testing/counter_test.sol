import "./counter.sol";

contract testSuite {
    Counter public counter;

    function beforeALl() public {
        counter = new Counter();
    }

    function checkInc() public {
        counter.inc();
        Assert.equal(counter.count(), 2, "count should be equal to 1");
    }

}