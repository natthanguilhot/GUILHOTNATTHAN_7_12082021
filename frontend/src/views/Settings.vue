<template>
  <div class="border rounded-2xl h-auto bg-white w-11/12 my-6  lg:mx-8 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl">
    <form id="signup" class="w-10/12 rounded-2xl m-auto flex flex-col justify-center items-center bg-white">
      <div class="flex flex-col justify-center items-center m-2 w-full">
        <label for="profile_picture" class=" cursor-pointer rounded-full hover:opacity-80 relative">
          <img v-if="user.profile_picture" :src="user.profile_picture" alt="Votre photo de profil" class="rounded-full h-32 w-32"/>
          <i class="fas fa-camera absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-black"></i>
        </label>
        <input id="profile_picture" name="profile_picture" type="file" accept="image/png, image/jpeg, image/jpg" class="hidden" @change="updateUserInformations"/>
      </div>
      <div class="flex flex-col justify-center items-center m-2 w-full">
        <label for="lastname">Nom</label>
        <input v-model="user.lastname" id="lastname" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="text" placeholder="Min. 3 caractères" minlength="3" maxlength="15"/>
      </div>
      <div class="flex flex-col justify-center items-center m-2 w-full">
        <label for="name">Prénom</label>
        <input v-model="user.name" id="name" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" required type="text" placeholder="Min. 3 caractères" minlength="3" maxlength="15"/>
      </div>
      <div class="flex flex-col justify-center items-center m-2 w-full">
        <label for="job">Job (optionnel)</label>
        <input v-model="user.job" id="job" class="border border-gray shadow-sm w-10/12 max-w-xs rounded pl-1 focus:ring-2 ring-offset-2 focus:ring-secondary" type="text" placeholder="Developpeur" minlength="3" maxlength="15"/>
      </div>
      <button @click.prevent="updateUserInformations" type="submit" class="text-center py-2 px-5 bg-secondary rounded m-2  focus:ring-4 focus:ring-prmary ring-offset-2">Mettre à jour les informations</button>
      <p v-if="error" class="text-primary error_message mt-4 -mb-10">{{ error }}</p>
      <p v-if="response" class="text-green-600 error_message mt-4 -mb-10">{{ response }}</p>
    </form>
    <button @click="this.modaleDeleteAccount = true" type="button" class="text-white mt-20 bg-primary px-4 py-2 rounded-2xl hover:bg-black hover:text-white focus:bg-black focus:text-white">Supprimer le compte <i class="fas fa-trash"></i></button>

    <div v-if="modaleDeleteAccount" class="fixed w-full h-screen inset-0 flex justify-center items-center bg-gray-200 bg-opacity-90">
      <div class="bg-white border rounded-2xl p-8 flex justify-center items-center flex-col relative m-1">
        <div class="rounded-full h-4 w-4 bg-primary absolute -top-1 -left-1 animate-ping"></div>
        <p class="text-primary">Voulez-vous vraiment supprimer votre compte ?</p>
        <div class="flex justify-around items-center w-full mt-4">
          <button @click="deleteAccount" class="bg-primary text-white px-4 py-2 rounded-2xl">Oui</button>
          <button @click="this.modaleDeleteAccount = false" class="bg-green-600 text-white px-4 py-2 rounded-2xl">Non</button>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  name: "Settings",
  components:{},
  data(){
    return{
      user:{
        lastname:'',
        name:'',
        job:'',
        profile_picture:null,
      },
      inputFile:null,
      response:'',
      error:'',
      bodyUserId:{
        userId:undefined,
      },
      modaleDeleteAccount:false,
    }
  },
  methods: {
    requestUserInformations(){
      this.bodyUserId.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      fetch('http://localhost:3000/api/auth/user/'+ `${this.bodyUserId.userId}`,{
        method: 'POST',
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
        },
        body: JSON.stringify(this.bodyUserId),
        })
        .then(response => response.json())
        .then(userInfo => {
          this.user.lastname = userInfo.lastname;
          this.user.name = userInfo.name;
          this.user.job = userInfo.job;
          this.user.profile_picture = userInfo.profile_picture;
        })
        .catch(err=>{console.log(err)})
    },
    updateUserInformations(){
      var formdata = new FormData();
      const inputFile = document.querySelector('#profile_picture');
      if(inputFile.files[0]){
        formdata.append("profile_picture", inputFile.files[0]);
      }
      formdata.append("userId", this.bodyUserId.userId);
      formdata.append("lastname", this.user.lastname);
      formdata.append("name", this.user.name);
      formdata.append("job", this.user.job);
      console.log('Requête de maj données envoyée !')
      fetch('http://localhost:3000/api/auth/user/' + `${this.bodyUserId.userId}`,{
        method: 'PUT',
        headers: {
          'Authorization' : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
        },
        body: formdata,
      })
      .then(response => response.json())
      .then(response => {
        this.response = response.message;
        if(response.error){
          this.error = response.error;
          setInterval(() => {
            this.error = null
          }, 5000);
        }
        this.requestUserInformations();
        setTimeout(() => {
          this.response = null
        }, 5000);
      })
    },
    deleteAccount(){
      console.log('delete acc');
      this.bodyUserId.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      fetch('http://localhost:3000/api/auth/user/' + `${this.bodyUserId.userId}`,{
        method: 'DELETE',
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
        },
        body: JSON.stringify(this.bodyUserId),
      })
      .then(response => response.json())
      .then(response => {
        localStorage.removeItem('authgroupomania');
        let splitURL = location.href.split('#/');
        window.location.href = splitURL[0];
        console.log(response);
      })
    },
  },
  beforeMount(){
    this.requestUserInformations();
  }
}
</script>

<style lang="scss" scoped>

</style>