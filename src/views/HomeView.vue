<template>
  <main>
    <div v-if="!address">
      <h1>Veuillez vous connecter</h1>
      <button @click="getUserAddress">Connecter le wallet</button>
    </div>
    <div v-else>

      <p>{{ address }}</p>

      <div v-if="Object.keys(hero).length === 0">
        <button @click="createHero">Créer le héro</button>
      </div>

      <div v-else>
        <p>Héro <i>{{ hero.name }}</i>, de niveau {{ hero.level }}</p>
        <div>
          <h4>Statistiques</h4>
          <ul>
            <li>Attaque: {{ hero.attack }}</li>
            <li>Défense: {{ hero.defense }}</li>
            <li>Rapidité: {{ hero.speed }}</li>
            <li>Chance: {{ hero.luck }}</li>
          </ul>
        </div>

        <div v-if="parseInt(hero.attributePoints) > 0">
          <UpdateAttributes :hero="hero" :increment-attributes="incrementAttributes"/>
        </div>
        <UpdateName :hero-name="hero.name" :update-name="updateName"/>
        <button @click="burnHero">Supprimer le hero</button>
        <button @click="getHero">refresh contract</button>
      </div>

    </div>
  </main>
</template>

<script>

import PlayerContract from "abi/PlayerContract.json";
import store from "store";
import UpdateAttributes from "@/components/UpdateAttributes.vue";
import UpdateName from "@/components/UpdateName.vue";

export default {
  name: 'HomeView',

  components: {
    UpdateAttributes,
    UpdateName,
  },

  data() {
    const { ethereum, Web3 } = window;
    const web3 = new Web3(Web3.givenProvider)

    ethereum.on('accountsChanged', async (r) => {
      this.setAddress(r.length > 0 ? r[0] : undefined);
      await this.getHero();
    });

    return {
      address: store.getters.address,
      hero: store.getters.hero,
      contract: new web3.eth.Contract(PlayerContract.abi, import.meta.env.VITE_CONTRACT_URI),
      web3,
      ethereum,
    }
  },

  methods: {
    setAddress(address) {
      this.address = address;
      store.commit('setAddress', address);
    },
    setHero(hero) {
      const { name, attack, defense, speed, luck, level, wins, attributePoints } = hero
      const params = name === undefined ? {} : { name, attack, defense, speed, luck, level, wins, attributePoints };
      this.hero = params;
      console.log(this.hero);
      store.commit('setHero', params);
    },
    async incrementAttributes(newHero) {
      this.contract.methods.incrementAttributes(
          newHero.attack - parseInt(this.hero.attack),
          newHero.defense - parseInt(this.hero.defense),
          newHero.speed - parseInt(this.hero.speed),
          newHero.luck - parseInt(this.hero.luck),
      ).send({ from: this.address })
       .then((r) => {
          console.log(r);
          this.getHero();
        }).catch((e) => {
          console.log(e.stack)
        });
    },
    async updateName(newName) {
      if (newName === this.hero.name) {
        return;
      }
      this.contract.methods.updateName(newName)
          .send({ from: this.address, value: this.web3.utils.toWei('0.001', 'ether')})
          .then((r) => {
            console.log(r);
            this.getHero();
            return true;
          }).catch((e) => {
            console.log(e.stack)
          });
    },
    async burnHero() {
      this.contract.methods.burnHero().send({ from: this.address })
          .then((r) => {
            console.log(r);
            this.setHero({});
          })
          .catch((e) => {
            console.log(e)
          })
    },
    async createHero() {
      this.contract.methods.createHero().send({ from: this.address })
          .then(async () => {
            await this.getHero();
          })
          .catch((e) => {
            alert("Erreur à la création du héro")
            console.log(e);
          })
    },
    async getHero() {
      this.contract.methods.getMyHero().call({ from: this.address})
        .then((r) => {
          const { status, hero } = r;
          if (status === 'error') {
            this.setHero({})
          } else {
            console.log(hero);
            this.setHero(hero);
          }
        });
    },
    async getUserAddress() {
      this.ethereum.request({ method: 'eth_requestAccounts' })
    },
  },

}
</script>
