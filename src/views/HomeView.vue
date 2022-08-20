<template>
  <main>
    <div v-if="!address">
      <h1>Veuillez vous connecter</h1>
      <button @click="getUserAddress">Connecter le wallet</button>
    </div>
    <div v-else>

      <p>{{ address }}</p>
      <button @click="getHero">Choper le hero</button>

      <div v-if="Object.keys(hero).length === 0">
        <button @click="createHero">Créer le héro</button>
      </div>

      <div v-else>
        <p>Nom du héro : {{ hero.name }}</p>
        <p>Niveau du héro : {{ hero.level }}</p>
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
      const { name, attack, defense, speed, luck, level, wins } = hero
      const params = name === undefined ? {} : { name, attack, defense, speed, luck, level, wins };
      this.hero = params;
      console.log(this.hero);
      store.commit('setHero', params);
    },
    async burnHero() {
      this.setHero({});
    },
    async createHero() {
      this.contract.methods.createHero().send({ from: this.address })
          .then((r) => {
            console.log(r);
          })
    },
    async getHero() {
      this.contract.methods.getMyHero().call({ from: this.address})
        .then((r) => {
          const { status, hero } = r;
          if (status === 'error') {
            alert("Pas de héro trouvé")
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
