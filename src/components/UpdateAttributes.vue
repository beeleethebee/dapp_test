<template>
  <h4>Nombre de Point d'attribut avant de sauvegarder -> {{ attributePoints }}</h4>
  <div>
    <label>
      <input type="number" v-model="tempHero.attack" :min="hero.attack" name="attack" @change="onChange"/>
      Attaque
    </label>
    <label>
      <input type="number" v-model="tempHero.defense" :min="hero.defense" name="defense" @change="onChange" />
      Défense
    </label>
    <label>
      <input type="number" v-model="tempHero.speed" :min="hero.speed" name="speed" @change="onChange"/>
      Rapidité
    </label>
    <label>
      <input type="number" v-model="tempHero.luck" :min="hero.luck" name="luck" @change="onChange"/>
      Chance
    </label>
  </div>
  <button @click="incrementAttributes(tempHero)" :disabled="attributePoints > 0">Sauvegarder</button>
</template>

<script>
export default {
  name: 'UpdateAttributes',
  props: {
    hero: Object,
    incrementAttributes: Function,
  },
  data() {
    return {
      attributePoints: parseInt(this.hero.attributePoints),
    };
  },
  setup(props) {
    const tempHero = {
      ...props.hero,
      attackPrevious: props.hero.attack,
      defensePrevious: props.hero.defense,
      speedPrevious: props.hero.speed,
      luckPrevious: props.hero.luck,
    };

    Object.keys(tempHero).forEach(function(el){
      tempHero[el] = parseInt(tempHero[el])
    })


    return { tempHero } ;
  },
  methods: {
    onChange(e) {
      e.preventDefault();
      const { name, value } = e.target;
      const diff = this.tempHero[`${name}Previous`] - parseInt(value);
      if (this.attributePoints + diff < 0) {
        e.target.value = this.tempHero[`${name}Previous`]
        return;
      }
      this.attributePoints = this.attributePoints + diff;
      this.tempHero[`${name}Previous`] = this.tempHero[name];
      this.tempHero[name] = parseInt(value);
    }
  }
}

</script>