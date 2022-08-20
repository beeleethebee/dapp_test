import { createStore } from "vuex";
import VuexPersist from "vuex-persist";

const vuexPersist = new VuexPersist({
  key: "store",
  storage: window.localStorage
});
export default createStore({
  state: {
      address: undefined,
      hero: {},
  },
  mutations: {
    setAddress(state, payload) {
      state.address = payload;
    },
    setHero(state, payload) {
      state.hero = payload;
    },
  },
  getters: {
    isConnected: (state) => state.address !== undefined,
    address: (state) => state.address,
    hero: (state) => state.hero,
  },
  plugins: [vuexPersist.plugin]
});