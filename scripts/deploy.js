const {ethers} = require('./setup');

async function main() {
    const Factory = await ethers.getContractFactory('Lesson2');
    const Factory2 = await ethers.getContractFactory('Homework2');

    const lesson2 = await Factory.deploy();
    const homework2 = await Factory2.deploy();

    await lesson2.waitForDeployment();
    await homework2.waitForDeployment();
    console.log('Contracts deployed to ' + await lesson2.getAddress() + ' and ' + await homework2.getAddress());
}

main().catch(error => {
    console.error(error)
    process.exitCode = -1;
});
