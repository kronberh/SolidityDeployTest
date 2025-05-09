const {ethers} = require('./setup');

async function main() {
    const Factory = await ethers.getContractFactory('Lesson2');
    const lesson2 = await Factory.deploy();

    await lesson2.waitForDeployment();
    console.log('Contract deployed to ' + await lesson2.getAddress());
}

main().catch(error => {
    console.error(error)
    process.exitCode = -1;
});
