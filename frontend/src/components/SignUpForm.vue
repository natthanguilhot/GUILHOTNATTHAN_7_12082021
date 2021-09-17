<template>
    <div class="flex flex-col justify-center items-center relative">
        <div class="max-w-screen-md m-auto absolute inset-0">
            <form id="signup" class="w-10/12 border rounded-2xl m-auto flex flex-col justify-center items-center my-8 shadow-lg min-h-[665px] bg-white">
                <img src="../assets/icon-left-font-monochrome-black.png" alt="Groupomania" class="p-4 m-4"/>
                <p class="text-lg text-center m-4">Retrouvez tout vos collègues en vous inscrivant !</p>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="email">Email</label>
                    <input v-model="user.email" id="email" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="email" placeholder="exemple@exemple.com" minlength="6"/>
                </div>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="password">Mot de passe</label>
                    <input v-model="user.password" id="password" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="password" placeholder="Min. 8 caractères" minlength="8" maxlength="20"/>
                </div>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="lastname">Nom</label>
                    <input v-model="user.lastname" id="lastname" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="text" placeholder="Doe" minlength="3" maxlength="15"/>
                </div>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="name">Prénom</label>
                    <input v-model="user.name" id="name" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="text" placeholder="John" minlength="3" maxlength="15"/>
                </div>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="job">Job (optionnel)</label>
                    <input v-model="user.job" id="job" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" type="text" placeholder="Developpeur" minlength="3" maxlength="15"/>
                </div>
                <button @click="signUp" type="button" class="text-center py-2 px-5 bg-red-200 rounded m-2  focus:ring-4 focus:ring-red-400 ring-offset-2">Créer un compte</button>
                <p>{{ response }}</p>
                <p class="my-4">Vous avez déjà un compte ? <span @click="displayForm" class="text-red-400 hover:underline hover:text-black cursor-pointer">Se connecter</span></p>
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
    }
  },
  methods:{
    signUp(){
      this.$emit('displayLoading');
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
        this.response= response.message || response.error;
        this.$emit('displayLoading');
      })
      .catch(error => error.json())
    },
    displayForm(){
        this.$emit('displayForm');
    }
  },
};
</script>

<style>

</style>