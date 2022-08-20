// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./HeroContract.sol";

contract PlayerContract is HeroContract {

  modifier hasHero() {
    require(heroes[msg.sender].level != 0);
    _;
  }

  modifier hasNotHero() {
    require(heroes[msg.sender].level == 0);
    _;
  }

  function getMyHero() external view returns (Hero memory hero, string memory status) {
    Hero memory senderHero = heroes[msg.sender];
    if (senderHero.level != 0) {
      hero = senderHero;
      status = "success";
    } else {
      status = "error";
    }
  }

  function burnHero() external hasHero returns (bool) {
    delete heroes[msg.sender];
    return true;
  }

  function createHero() external hasNotHero returns (Hero memory)  {
    Hero memory newHero = _initializeHero();
    heroes[msg.sender] = newHero;
    return newHero;
  }

}
