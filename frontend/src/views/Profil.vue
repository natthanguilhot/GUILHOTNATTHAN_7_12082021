<template>
<div class="flex flex-col justify-center items-center w-full max-w-3xl">
  <div class="border rounded-2xl h-auto bg-white w-11/12 m-1 my-6 lg:mx-8 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl">
    <div class="flex justify-center items-start w-full m-4">
      <img alt="photo de profil de l'utilisateur" :src="userInformations.profile_picture" class="h-32 w-32 rounded-2xl text-center object-cover"/>
      <div class="flex flex-col">
        <p class="m-2">{{ userInformations.name }} {{ userInformations.lastname }}</p>
        <p class="m-2">{{ userInformations.job }}</p>
      </div>
    </div>
  </div>
        <div v-for="post in userInformations.Posts" :key="post.id" :data-postid="post.id" class="border rounded-2xl h-auto bg-white w-11/12 m-1 lg:my-4 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl relative">
            <div :data-userid="post.userId" class="flex justify-around items-start mb-6 ">
                <img v-if="userInformations.profile_picture" :src="userInformations.profile_picture" :alt="'Photo profil de '+ userInformations.name + userInformations.lastname" class="bg-gray-900 h-16 w-16 rounded-2xl">
                <div class="flex flex-col justify-around items-start m-2">
                    <h2>{{ userInformations.name }} {{userInformations.lastname}}</h2>
                    <p>{{ formatCreatedAt(post.createdAt) }}</p>
                </div>
                <button v-if="post.creator == $store.state.user.id || $store.state.user.account_type == true" @click="deletePost(post.postId)" aria-label="Suppression du poste" type="button" class="border border-primary rounded-full px-3 py-1 absolute top-1 right-1 text-primary hover:text-white hover:bg-primary"><i class="fas fa-trash"></i></button>
            </div>
            <router-link :to="{name: 'FeedId', params : {id: post.id}}" class="w-full">
                <p v-if="post.content" class="w-full" v-html="returnLine(post.content)"></p>
                <img v-if="post.files" :src="post.files" alt="Image liée au post" class="rounded-2xl my-4 mx-auto border">
            </router-link>
            <div class="flex jusitfy-start items-center mt-4">
                <!-- <button type="button" class="btn_vote group" @click="sendRequestLikePost(post.postId)"><i class="fas fa-caret-square-up"></i><span class="absolute -top-6 group-hover:text-primary">{{ userInformations.Posts.Likes.length }}</span></button> -->
                <!-- <button type="button" class="h-10 w-10 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary relative group" @click="sendRequestDislikePost(post.postId)"><i class="fas fa-thumbs-down"></i><span class="absolute -top-6 group-hover:text-primary">{{ post.Likes.length }}</span></button> -->
                <!-- <div class="ml-4">
                    {{ post.Comments.length }} commentaire(s)
                </div> -->
            </div>
        </div>
</div>
</template>

<script>
export default {
  name: "Profil",
  data(){
    return {
      body: {
        userId:'',
        getUserId:'',
      },
      userInformations:[],
    }
  },
  methods:{
    getUserProfil(){
      this.body.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      this.body.getUserId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      fetch('http://localhost:3000/api/auth/userprofil/' + `${this.body.userId}`,{
          method: 'POST',
          headers: {
              'Accept': 'application/json', 
              'Content-Type': 'application/json',
              "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
          },
          body: JSON.stringify(this.body),
      })
      .then(response => response.json())
      .then(response => {
        response.Posts.reverse();
        this.userInformations = response;
        console.log(this.userInformations);
      });
    },
    returnLine(content){
      let contenu = content;
      console.log(contenu);
      let returnLine = contenu.split('\n').join(' <br/> ');
      return returnLine;
    },
    formatCreatedAt(date){
      let splitDateTime = date.split('T');
      let splitDate = splitDateTime[0].split('-');
      let splitTime = splitDateTime[1].split(':');
      let trueHour = parseInt(splitTime[0])+2; // On rajoute 2 heures pour faire correspondre à l'heure actuelle
      date = 'Créé le ' + splitDate[2] + '/' + splitDate[1] + '/' + splitDate[0] + ' à ' + trueHour + ':' + splitTime[1];
      return date;
    },
  },
  beforeMount(){
    this.getUserProfil();
  },
}
</script>

<style>

</style>