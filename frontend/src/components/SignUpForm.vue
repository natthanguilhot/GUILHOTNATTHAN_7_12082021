<template>
  <div class="flex flex-col justify-center items-center relative">
    <div class="max-w-screen-md m-auto absolute inset-0">
      <form id="signup" class="w-10/12 border rounded-2xl m-auto flex flex-col justify-center items-center my-8 shadow-lg min-h-[665px] bg-white">
        <img src="../assets/icon-left-font-monochrome-black.png" alt="Groupomania" class="p-4 m-4"/>
        <p class="text-lg text-center m-4">Retrouvez tout vos collègues en vous inscrivant !</p>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="email">Email</label>
          <input v-model="user.email" id="email" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="email" placeholder="exemple@exemple.fr" minlength="6"/>
          <p v-if="regexEmail" class="text-primary m-1">{{ regexEmail }}</p>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="password">Mot de passe</label>
          <input v-model="user.password" id="password" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="password" placeholder="Min. 8 caractères" minlength="8" maxlength="20"/>
          <p v-if="password" class="text-primary m-1">{{ password }}</p>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="lastname">Nom</label>
          <input v-model="user.lastname" id="lastname" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="text" placeholder="Min. 3 caractères" minlength="3" maxlength="15"/>
          <p v-if="lastname" class="text-primary m-1">{{ lastname }}</p>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="name">Prénom</label>
          <input v-model="user.name" id="name" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="text" placeholder="Min. 3 caractères" minlength="3" maxlength="15"/>
          <p v-if="name" class="text-primary m-1">{{ name }}</p>
        </div>
        <div class="flex flex-col justify-center items-center m-2 w-full">
          <label for="job">Job (optionnel)</label>
          <input v-model="user.job" id="job" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" type="text" placeholder="Developpeur" minlength="3" maxlength="15"/>
        </div>
        <button @click.prevent="signUp" type="submit" class="text-center py-2 px-5 bg-secondary rounded m-2  focus:ring-4 focus:ring-prmary ring-offset-2">Créer un compte</button>
        <p v-if="error" class="text-primary error_message">{{ error }}</p>
        <p v-if="response" class="text-green-600">{{ response }}</p>
        <p class="my-4">Vous avez déjà un compte ? <span @click="displayForm" class="text-primary hover:underline hover:text-black cursor-pointer">Se connecter</span></p>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "SignUpForm",
  data(){
    return {
      user:{
        email:'',
        password:'',
        lastname:'',
        name:'',
        job:'',
      },
      response:'',
      error:'',
      regexEmail:'',
      password:'',
      lastname:'',
      name:'',
    }
  },
  methods:{
    signUp(){
      this.$emit('displayLoading');
      const REGEX_EMAIL = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if(!REGEX_EMAIL.test(this.user.email)){
        this.regexEmail = 'Email non conforme !';
        this.$emit('displayLoading');
        setTimeout(() => {
          this.regexEmail = '';
        }, 3000);
      } else if(this.user.password.length < 8){
        this.password = 'Mot de passe non conforme !';
        this.$emit('displayLoading');
        setTimeout(() => {
          this.password = '';
        }, 3000);
      }
      else if(this.user.lastname.length < 3) {
        this.lastname = 'Nom non conforme !';
        this.$emit('displayLoading');
        setTimeout(() => {
          this.lastname = '';
        }, 3000);
      } else if(this.user.name.length < 3) {
        this.name = 'Prénom non conforme !';
        this.$emit('displayLoading');
        setTimeout(() => {
          this.name = '';
        }, 3000);
      } else { // Si toutes les vérifications son ok alors on envoie au serveur !
        fetch('http://localhost:3000/api/auth/signup',
        {
          method: 'POST',
          headers: { 
          'Accept': 'application/json', 
          'Content-Type': 'application/json' 
          },
          body: JSON.stringify(this.user),
        })
        .then(response => response.json())
        .then(response => {
          console.log(response)
          this.response = response.message;
          this.error = response.error;
          this.$emit('displayLoading');
          setTimeout(() => {
          this.response = ""; this.error = ""; this.user.email = ""; this.user.password = ""; this.user.lastname = ""; this.user.name = ""; this.user.job = "";
          }, 2000);
        })
        .catch(error => error.json())
      }
    },
    displayForm(){
        this.$emit('displayForm');
    }
  },
};
</script>

<style lang="scss" scoped>
.error_message {
  animation: error_message 5s ease-in 0s 1 normal both;
}
@keyframes error_message {
  0%{
    transform:translateX(0px);
  }
  2%{
    transform:translateX(30px);
  }
  4%{
    transform:translateX(-30px);
  }
  6%{
    transform:translateX(30px);
  }
  8%{
    transform:translateX(0px);
  }
  100%{
    transform:translateX(0px);
  }
}
</style>