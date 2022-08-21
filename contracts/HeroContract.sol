// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HeroContract {
    struct Hero {
        string name;
        uint lifePoint;
        uint wins;
        uint8 level;
        uint8 attack;
        uint8 defense;
        uint8 speed;
        uint8 luck;
        uint8 attributePoints;
    }
    mapping(address => Hero) public heroes;
    uint8 internal constant MAX_ATTRIBUTE_POINTS = 50;

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
        newHero.attack = 1;
        newHero.defense = 1;
        newHero.speed = 1;
        newHero.luck = 1;
        newHero.lifePoint = 100;
        newHero.wins = 0;
        newHero.attributePoints = 10;
        return newHero;
    }
}