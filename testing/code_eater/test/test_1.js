const TestContract = artifacts.require("test_1");

TestContract("TestContract", () => {
    it("Should return hello testing", async () => {
        const test_1 = await TestContract.deployed();
        const result = await test_1.print();

        console.log(result);
    });
})