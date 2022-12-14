// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./HeroContract.sol";

contract PlayerContract is HeroContract {

  function incrementAttributes(uint8 _attack, uint8 _defense, uint8 _speed, uint8 _luck) external hasHero {
    uint8 sum = _attack + _defense + _speed + _luck;
    require(sum <= heroes[msg.sender].attributePoints, "Not enough attribute points");
    require(sum > 0, "No attribute points to increment");
    if (_attack > 0) {
      heroes[msg.sender].attack += _attack;
    }
    if (_defense > 0) {
      heroes[msg.sender].defense += _defense;
    }
    if (_speed > 0) {
      heroes[msg.sender].speed += _speed;
    }
    if (_luck > 0) {
      heroes[msg.sender].luck += _luck;
    }
    heroes[msg.sender].attributePoints -= sum;
  }

  function updateName(string calldata _newName) payable external hasHero {
    require(msg.value == 0.001 ether, "Not enough ether");
    heroes[msg.sender].name = _newName;
  }

  function getMyHero() external view returns (Hero memory hero, string memory status) {
    Hero memory senderHero = heroes[msg.sender];
    if (senderHero.level > 0) {
      hero = senderHero;
      status = "success";
    } else {
      status = "error";
    }
  }

  function getHero(address _address) external view returns (Hero memory hero, string memory status) {
    Hero memory senderHero = heroes[_address];
    if (senderHero.level > 0) {
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
