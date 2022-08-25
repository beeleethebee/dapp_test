// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HeroContract {
    struct Hero {
        string name;
        uint16 lifePoint;
        uint16 wins;
        uint8 level;
        uint8 attack;
        uint8 defense;
        uint8 speed;
        uint8 luck;
        uint8 attributePoints;
    }

    mapping(address => Hero) public heroes;

    modifier hasHero() {
        require(heroes[msg.sender].level > 0);
        _;
    }

    modifier hasNotHero() {
        require(heroes[msg.sender].level == 0);
        _;
    }

    function _initializeHero() internal pure returns (Hero memory) {
        Hero memory newHero;
        newHero.name = "Hero";
        newHero.level = 1;
        newHero.attack = 5;
        newHero.defense = 5;
        newHero.speed = 5;
        newHero.luck = 5;
        newHero.lifePoint = 30;
        newHero.wins = 0;
        newHero.attributePoints = 10;
        return newHero;
    }
}