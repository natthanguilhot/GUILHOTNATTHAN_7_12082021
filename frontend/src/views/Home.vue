/* eslint-disable */
<template>
  <div class="home flex flex-col justify-center items-center">
    <h1 class="text-5xl font-bold text-red-500 my-8 text-center">Groupomania</h1>
    <div class="max-w-screen-md m-auto">
      <form id="signup" class="w-10/12 border rounded-2xl m-auto flex flex-col justify-center items-center my-8">
        <img src="../assets/icon-left-font-monochrome-black.png" alt="Groupomania" class="p-4 -my-28"/>
        <p class="text-lg text-center md:-mt-16 md:mb-16">Retrouvez tout vos collègues en vous inscrivant !</p>

        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="email">Email</label>
          <input v-model="user.email" id="email" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1" required type="email" placeholder="exemple@exemple.com" minlength="6"/>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="password">Mot de passe</label>
          <input v-model="user.password" id="password" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1" required type="password" minlength="8" maxlength="20"/>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="lastname">Nom</label>
          <input v-model="user.lastname" id="lastname" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1" required type="text" placeholder="Doe" minlength="3" maxlength="15"/>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="name">Prénom</label>
          <input v-model="user.name" id="name" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1" required type="text" placeholder="John" minlength="3" maxlength="15"/>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="job">Job (optionnel)</label>
          <input v-model="user.job" id="job" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1" type="text" placeholder="Comptable" minlength="3" maxlength="15"/>
        </div>
        <button @click="signUp" type="submit" class="text-center py-2 px-5 bg-red-200 rounded m-2">Créer un compte</button>
        <p>{{ response }}</p>
        <p class="my-4">Vous avez déjà un compte ? <router-link to="/about" class="text-red-400 hover:underline hover:text-black">Se connecter</router-link></p>
      </form>
    </div>
    <LoadingSpinner v-if="isLoading"/>
    <!-- test commit -->
  </div>
</template>

<script>
// @ is an alias to /src
import LoadingSpinner from "@/components/LoadingSpinner.vue";

export default {
  name: "Home",
  components:{
    LoadingSpinner,
  },
  beforeCreate() {
    this.$options.components.LoadingSpinner = require('../components/LoadingSpinner.vue').default;
  },
  data(){
    return {
      user:{
        email:'',
        password:'',
        lastname:'',
        name:'',
        job:'',
      },
      isLoading:false,
      response:''
    }
  },
  components: {
    
  },
  methods:{
    signUp(){
      this.isLoading = true;
      fetch('http://localhost:3000/api/auth/signup',
       {
        method: 'POST',
        headers: { 
        'Accept': 'application/json', 
        'Content-Type': 'application/json' 
        },
            body: JSON.stringify(this.user), // On envoie les données au serveur
      })
      .then(response => response.json())
      .then(response => {
        console.log(response)
        this.response= response.message;
        this.isLoading = false;
      })
    }
  },
};
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');
html, body {
  font-family: 'Montserrat', sans-serif;
}
input {
  outline: none;
}
</style>