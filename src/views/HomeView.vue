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
            <li>Points d'attributs à répartir : {{ hero.attributePoints }}</li>
          </ul>
        </div>
        <button @click="burnHero">Supprimer le hero</button>
      </div>

    </div>
  </main>
</template>

<script>

import PlayerContract from "abi/PlayerContract.json";
import store from "store";

export default {

  name: 'HomeView',
  components: {

  },
  data() {
    const { ethereum, Web3 } = window;
    const web3 = new Web3(Web3.givenProvider)

    ethereum.on('accountsChanged', async (r) => {
      this.setAddress(r.length > 0 ? r[0] : undefined);
      await this.getHero();
    });

    console.log(store.getters.hero)
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
    async burnHero() {
      this.contract.methods.burnHero().send({ from: this.address })
          .then((r) => {
            console.log(r);
            this.setHero({});
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
