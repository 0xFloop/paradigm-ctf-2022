// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/MERKLEDROP/Setup.sol";
import "../src/MERKLEDROP/MerkleDistributor.sol";
import "../src/MERKLEDROP/MerkleProof.sol";

contract ContractTest is Test {

    function testExploit() public {
        vm.createSelectFork(vm.rpcUrl("paradigm"));
        Setup setup = Setup(0x273fF4dC78246CeB36f11B17ACcf35B6FCC50Ca6);
        MerkleDistributor merkleDist = setup.merkleDistributor();
        Token token = setup.token();

        for(uint i=0; i<64;i++){
            console.log(merkleDist.isClaimed(i));
        }
        string memory test = vm.readFile("src/MERKLEDROP/tree.json");
        bytes memory fileBytes = bytes(test);

        console.log(token.balanceOf(address(merkleDist)));

        uint8 hexCounter = 0;
        for(uint i = 0;i<fileBytes.length;i++){
            if(fileBytes[i] == 0x30){
                if(fileBytes[i+1] == 0x78){
                    console.log("Another hex");
                    if(hexCounter == 0){
                        bytes memory claimeeBytes;
                        address claimee;
                        for(uint j = 0;j<20;j++){
                            claimeeBytes = abi.encodePacked(claimeeBytes, fileBytes[i+2+j]);
                        }
                        console.log(address(bytes20(claimeeBytes)));
                        break;
                        hexCounter++;
                    }else if(hexCounter == 1){
                        hexCounter++;
                    }else if(hexCounter == 2){
                        hexCounter++;
                    }else if(hexCounter == 3){
                        hexCounter++;
                    }else if(hexCounter == 4){
                        hexCounter++;
                    }else if(hexCounter == 5){
                        hexCounter++;
                    }else if(hexCounter == 6){
                        hexCounter = 0;
                    }
                }
            }
        }
    }
}