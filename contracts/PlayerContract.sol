// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./HeroContract.sol";

contract PlayerContract is HeroContract {

  function incrementAttributes(uint8 _attack, uint8 _defense, uint8 _speed, uint8 _luck) public hasHero {
    uint8 sum = _attack + _defense + _speed + _luck;
    Hero storage hero = heroes[msg.sender];
    require(sum <= hero.attributePoints, "Not enough attribute points");
    require(sum > 0, "No attribute points to increment");

  if (hero.attack + _attack > MAX_ATTRIBUTE_POINTS) {
      hero.attack = MAX_ATTRIBUTE_POINTS;
    } else {
        hero.attack += _attack;
    }
    if (hero.defense + _defense > MAX_ATTRIBUTE_POINTS) {
      hero.defense = MAX_ATTRIBUTE_POINTS;
    } else {
      hero.defense += _defense;
    }
    if (hero.speed + _speed > MAX_ATTRIBUTE_POINTS) {
      hero.speed = MAX_ATTRIBUTE_POINTS;
    } else {
      hero.speed += _speed;
    }
    if (hero.defense + _defense > MAX_ATTRIBUTE_POINTS) {
      hero.defense = MAX_ATTRIBUTE_POINTS;
    } else {
      hero.defense += _defense;
    }
    hero.attributePoints -= sum;
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
