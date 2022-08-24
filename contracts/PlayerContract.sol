// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./HeroContract.sol";

contract PlayerContract is HeroContract {

  function incrementAttributes(uint8 _attack, uint8 _defense, uint8 _speed, uint8 _luck) public hasHero {
    uint8 sum = _attack + _defense + _speed + _luck;
    require(sum <= heroes[msg.sender].attributePoints, "Not enough attribute points");
    require(sum > 0, "No attribute points to increment");
    heroes[msg.sender].attack += _attack;
    heroes[msg.sender].defense += _defense;
    heroes[msg.sender].speed += _speed;
    heroes[msg.sender].defense += _defense;
    heroes[msg.sender].attributePoints -= sum;
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
