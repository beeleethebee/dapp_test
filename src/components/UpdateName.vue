<template>
  <div>
    <div v-if="showForm">
      <h1>Update Name</h1>
      <label>
        <input type="text" v-model="heroName" name="name" />
      </label>
      <button @click="save">Sauvegarder</button>
    </div>
    <button @click="showForm = !showForm"> {{ showForm ? 'Annuler' : 'Changer de nom' }}</button>
  </div>

</template>

<script>
export default {
  name: 'UpdateName',
  props: {
    heroName: String,
    updateName: Function,
  },
  data() {
    return {
      showForm: false,
    };
  },
  methods: {
    save() {
      this.updateName(this.heroName).then(() => this.showForm = false);
    }
  }
}

</script>