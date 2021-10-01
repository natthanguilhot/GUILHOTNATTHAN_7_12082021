/* eslint-disable */
<template>
  <div class="home">
    <h1 class="text-5xl font-bold text-red-500 my-8 text-center">Groupomania</h1>
    <SignUpForm @displayLoading="$store.commit('displayLoading')" @displayForm="displayForm" :class="{goBack: whichCard == false, goFront: whichCard == true}"/>
    <LoadingSpinner v-if="$store.state.isLoading"/>
    <LogInForm @displayLoading="$store.commit('displayLoading')" @displayForm="displayForm" :class="{goBack: whichCard == true, goFront: whichCard == false}"/>
  </div>
</template>

<script>
// @ is an alias to /src
import LoadingSpinner from "@/components/LoadingSpinner.vue";
import SignUpForm from "@/components/SignUpForm.vue";
import LogInForm from "@/components/LogInForm.vue";

export default {
  name: "Home",
  components:{
    LoadingSpinner,
    SignUpForm,
    LogInForm
  },
  beforeCreate() {
    this.$options.components.LoadingSpinner = require('../components/LoadingSpinner.vue').default;
    this.$options.components.SignUpForm = require('../components/SignUpForm.vue').default;
    this.$options.components.LogInForm = require('../components/LogInForm.vue').default;
  },
  data(){
    return {
      whichCard:null,
    }
  },
  methods:{
    displayForm(){
      this.whichCard = !this.whichCard;
    }
  },
};
</script>

<style lang="scss" scoped>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');
html, body {
  font-family: 'Montserrat', sans-serif;
}
input {
  outline: none;
}
.goBack {
  animation: goBack 1s ease 0s normal both;
}
@keyframes goBack {
  0%{
    z-index: 1;
  }
  50% {
    transform: translateX(-30%) scale(0.8);
    z-index: 0;
  }
  100% {
    transform: translateX(0%) scale(0.6);
    z-index: -1;
  }
}
.goFront {
  animation: goFront 1s ease 0s normal both;
}
@keyframes goFront {
  0%{
    z-index: -1;
    transform: scale(0.6);
  }
  30% {
    z-index: 0;
  }
  100% {
    transform: scale(1);
    z-index: 1;
  }
}
</style>