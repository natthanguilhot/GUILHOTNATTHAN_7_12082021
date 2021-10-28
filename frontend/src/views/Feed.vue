<template>
    <div class="flex flex-col justify-center items-center w-full max-w-3xl">
        <FormPost @MajPost="APIRequest"/>
        <div v-for="post in listPosts" :key="post.postId" :data-postid="post.postId" class="border rounded-2xl h-auto bg-white w-11/12 m-1 lg:my-4 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl relative">
            <div :data-userid="post.userId" class="flex justify-around items-start mb-6 ">
                <img v-if="post.User.profile_picture" :src="post.User.profile_picture" :alt="'Photo profil de '+ post.User.name + post.User.lastname" class="bg-gray-900 h-16 w-16 rounded-2xl object-cover">
                <div class="flex flex-col justify-around items-start m-2">
                    <h2>{{ post.User.name }} {{post.User.lastname}}</h2>
                    <p>{{ post.createdAt }}</p>
                </div>
                <button v-if="post.userId == this.userId || $store.state.user.account_type == true" @click="deletePost(post.postId)" aria-label="Suppression du poste" type="button" class="border border-primary rounded-full px-3 py-1 absolute top-1 right-1 text-primary hover:text-white hover:bg-primary"><i class="fas fa-trash"></i></button>
            </div>
            <router-link :to="{name: 'FeedId', params : {id: post.postId}}" class="w-full">
                <p v-if="post.content" class="w-full" v-html="returnLine(post.content)"></p>
                <img v-if="post.files" :src="post.files" alt="Image liée au post" class="rounded-2xl my-4 mx-auto border">
            </router-link>
            <div class="flex jusitfy-start items-center mt-4">
                <button type="button" class="btn_vote group" @click="sendRequestLikePost(post.postId)"><i class="fas fa-caret-square-up"></i><span class="absolute -top-6 group-hover:text-primary">{{ post.Likes.length }}</span></button>
                <div class="ml-4">
                    {{ post.Comments.length }} commentaire(s)
                </div>
            </div>
        </div>
        <div v-if="notifLike" class="fixed bottom-0 left-1/2 transform -translate-x-1/2 bg-green-400 m-4 py-2 px-4 rounded-2xl spawn_animation">
            <p>{{ notifLike.message }}</p>
        </div>
    </div>
</template>

<script>
import FormPost from "@/components/FormPost";
import store from "@/store/index";

export default {
    name: "Feed",
    components:{
        FormPost,
    },
    data(){
        return {
            listPosts: [],
            userId : undefined,
            notifLike:"",
        }
    },
    methods: {
        APIRequest(){
            fetch('http://localhost:3000/api/posts',{
                method: 'GET',
                headers: {
                    authorization : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token
                }
            })
            .then(response => response.json())
            .then(posts => {
                this.listPosts = Object.values(posts);
                for (const post of this.listPosts) { // On split les formatt actuel pour les regrouper au format voulu
                    let splitDateTime = post.createdAt.split('T');
                    let splitDate = splitDateTime[0].split('-');
                    let splitTime = splitDateTime[1].split(':');
                    let trueHour = parseInt(splitTime[0])+2; // On rajoute 2 heures pour faire correspondre à l'heure actuelle
                    post.createdAt = 'Créé le ' + splitDate[2] + '/' + splitDate[1] + '/' + splitDate[0] + ' à ' + trueHour + ':' + splitTime[1];
                }
            });
        },
        returnLine(content){
            let contenu = content;
            console.log(contenu);
            let returnLine = contenu.split('\n').join(' <br/> ');
            return returnLine;
        },
        getUserId(){
            this.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
        },
        sendRequestLikePost(postId){
            this.notifLike = true;
            let bodyLike = {
                userId : this.userId,
                postId : postId,
                commentId : null,
            };
            fetch('http://localhost:3000/api/likes/post/' + `${JSON.stringify(postId)}`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body: JSON.stringify(bodyLike),
            })
            .then(response => response.json())
            .then(response => {
                this.notifLike = response;
                this.APIRequest();
                setTimeout(() => {
                    this.notifLike = null;
                },2100)
            });
        },
        deletePost(postId) {
            let bodyDeletePost = {
                userId : this.userId,
                postId : postId,
            };
            fetch('http://localhost:3000/api/posts/' + `${JSON.stringify(postId)}`,{
                method: 'DELETE',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body: JSON.stringify(bodyDeletePost),
            })
            .then(response => response.json())
            .then(response => {
                this.APIRequest();
                console.log(response);
            });
        }
    },
    beforeMount() {
        store.dispatch('getUserInformations');
        this.APIRequest();
        this.getUserId();
    }
}
</script>

<style lang="scss">
.spawn_animation {
    animation: spawn_animation 2s ease 0s normal both;
}
@keyframes spawn_animation {
    0%{
        transform: translateY(50px);
        opacity:0;
    }
    10%{
        transform: translateY(0px);
        opacity:1;
    }
    90%{
        transform: translateY(0px);
        opacity:1;
    }
    100%{
        transform: translateY(50px);
        opacity:0;
    }
}
.btn_vote {
    @apply h-10 w-10 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary relative;
}
</style>