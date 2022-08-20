// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract PlayerContract {
  struct Hero {
    string name;
    uint8 level;
    uint8 attack;
    uint8 defense;
    uint8 speed;
    uint8 luck;
    uint16 lifePoint;
    uint16 wins;
  }

  mapping(address => Hero) public heroes;

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

  function createHero() public returns (Hero memory)  {
    Hero memory newHero;
    newHero.name = "Hero";
    newHero.level = 1;
    newHero.attack = 1;
    newHero.defense = 1;
    newHero.speed = 1;
    newHero.luck = 1;
    newHero.lifePoint = 100;
    newHero.wins = 0;
    heroes[msg.sender] = newHero;
    return newHero;
  }

}
