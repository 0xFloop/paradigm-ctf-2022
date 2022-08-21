// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/RESCUE/MasterChefHelper.sol";
import "../src/RESCUE/Setup.sol";
import "../src/RESCUE/UniswapV2Like.sol";
import "../src/mocks/ERC20Mock.sol";
import "../src/mocks/WETH9MOCK.sol";

contract ContractTest is Test {
    address setupAddress = 0x66d929125dE87064d901fd811625B64A3C5BebeD;
    Setup public setup = Setup(setupAddress);
    MasterChefLike public constant masterchef = MasterChefLike(0xc2EdaD668740f1aA35E4D8f227fB8E17dcA888Cd);
    UniswapV2RouterLike public constant router = UniswapV2RouterLike(0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);
    WETH9MOCK public constant weth = WETH9MOCK(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    uint256 MAX_NUM = 2**256 - 1;

    function testExploit() public {
        vm.createSelectFork(vm.rpcUrl("paradigm"));
        MasterChefHelper mcHelper = setup.mcHelper();

        ERC20Mock erc20 = new ERC20Mock();

        erc20.mint(address(this), 100000000);
        weth.approve(address(router),10000);
        erc20.approve(address(router),10000);


        (uint amountA, uint amountB, uint liquidity) = router.addLiquidity(address(erc20),address(weth), 100,0,0,0,address(this), block.timestamp + 1000);

        console.log(amountA);
        console.log(amountB);
        console.log(liquidity);

        

    }
}
