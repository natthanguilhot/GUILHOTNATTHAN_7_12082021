<template>
    <div class="flex flex-col justify-center items-center relative">
        <div class="max-w-screen-md m-auto absolute inset-0">
            <form id="login" class="w-10/12 border rounded-2xl m-auto flex flex-col justify-center items-center my-8 shadow-lg min-h-[665px] bg-white">
                <img src="../assets/icon-left-font-monochrome-black.png" alt="Groupomania" class="p-4 m-4"/>
                <p class="text-lg text-center m-4">Retrouvez tout vos collègues en vous connectant !</p>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="email">Email</label>
                    <input v-model="user.email" id="emailLogIn" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="email" minlength="6"/>
                </div>
                <div class="flex flex-col justify-center items-center m-2 w-full">
                    <label for="password">Mot de passe</label>
                    <input v-model="user.password" id="passwordLogIn" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-red-300" required type="password" minlength="8" maxlength="20"/>
                </div>
                <button @click="LogIn" type="button" class="text-center py-2 px-5 bg-red-200 rounded m-2  focus:ring-4 focus:ring-red-400 ring-offset-2">Se connecter</button>
                <p>{{ response }}</p>
                <p class="my-4">Vous n'avez pas de compte ? <span @click="displayForm" class="text-red-400 hover:underline hover:text-black cursor-pointer">S'inscrire</span></p>
            </form>
        </div>
    </div>
</template>

<script>
export default {
  name: "LogInForm",
  data(){
    return {
      user:{
        email:'',
        password:'',
      },
      response:'',
    }
  },
  methods:{
    LogIn(){
        this.$emit('displayLoading');
        this.isLoading = true;
        fetch('http://localhost:3000/api/auth/login',
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
            this.response = response.message || response.error;
            if(response.token){
                localStorage.setItem('authgroupomania', JSON.stringify({userId : response.userId, token :response.token}));
                console.log(window.location.href)
                window.location.href = window.location.href+"main"; // on envoie sur la page confirmation    
            }
            this.$emit('displayLoading');
        })
    },
    displayForm(){
        this.$emit('displayForm');
    }
  },
};
</script>

<style lang="scss">

</style>