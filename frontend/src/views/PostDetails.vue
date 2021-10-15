<template>
    <div class="flex flex-col justify-center items-center w-full max-w-3xl">
        <div class="border rounded-2xl h-auto bg-white w-11/12 m-1 my-6 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl relative">
            <div :data-userid="post.userId" class="flex justify-around items-start mb-6 ">
                <img v-if="user.profile_picture" :src="user.profile_picture" alt="PP de l'utilisateur" class="bg-gray-900 h-16 w-16 rounded-2xl">
                <img v-else src="http://localhost:3000/images/users/default_PP.jpg" alt="PP de l'utilisateur" class="bg-gray-900 h-16 w-16 rounded-2xl">
                <div class="flex flex-col justify-around items-start m-2">
                    <h2>{{ user.name }} {{user.lastname}}</h2>
                    <p>{{ post.createdAt }}</p>
                </div>
                <button v-if="post.userId == this.userId" @click="deletePost(post.postId)" type="button" class=" border border-primary rounded-full px-3 py-1 absolute top-1 right-1 text-primary hover:text-white hover:bg-primary"><i class="fas fa-trash"></i></button>
            </div>
            <p>{{ post.content }}</p>
            <a v-if="post.files" :href="post.files" target="_blank" rel="noopener"><img v-if="post.files" :src="post.files" alt="Image liée au post" class="rounded-2xl my-4 mx-auto border"></a>
            <div class="flex jusitfy-start items-center mt-4">
                <button type="button" class="h-10 w-10 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary relative" @click="sendRequestLikePost(post.postId)"><i class="fas fa-thumbs-up"></i><span class="absolute -top-6">{{ likes.length }}</span></button>
                <button type="button" class="h-10 w-10 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary relative" @click="sendRequestDislikePost(post.postId)"><i class="fas fa-thumbs-down"></i><span class="absolute -top-6">{{ likes.length }}</span></button>
            </div>
            <div class="w-full">
                <div id="comments" class="flex jusitfy-start items-start my-2 border p-2 rounded-2xl w-full h-auto relative" v-for="comment in comments" :key="comment.id">
                    <a :href="comment.User.profile_picture" class="w-10 h-10 block" target="_blank" rel="noopener"><img alt="Photo de l'utilisateur" :src="comment.User.profile_picture" class="w-full h-full rounded-2xl mr-1"/></a>
                    <div class="flex flex-col ml-2">
                        <p class="text-xl">{{ comment.User.lastname }} {{comment.User.name}}</p>
                        <p class="w-full break-all">{{ comment.content }}</p>
                    </div>
                    <button v-if="comment.user_id == this.userId" @click="deleteMyComment(comment.id)" type="button" class=" border border-primary rounded-full px-3 py-1 absolute top-1 right-1 text-primary hover:text-white hover:bg-primary"><i class="fas fa-trash"></i></button>
                    <!-- <div class="flex flex-col jusitfy-start items-center">
                        <button type="button" class="h-7 w-7 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary" @click="test"><i class="fas fa-thumbs-up"></i></button>
                        <button type="button" class="h-7 w-7 flex justify-center items-center m-1 p-1 border border-primary rounded-2xl text-primary hover:text-white hover:bg-primary" @click="test"><i class="fas fa-thumbs-down"></i></button>
                    </div> -->
                </div>
            </div> 
            <div class="w-full flex flex-col justify-center items-start">
                <div class="w-full">
                    <textarea id="contentComment" v-model="addCommentBody.content" type="text" class="border border-primary rounded w-full p-1" minlength="2" placeholder="Insérez un commentaire ici."/>
                </div>
                <button @click="addComment" class="border rounded-2xl text-primary px-4 py-2 my-2 hover:text-white hover:bg-primary">Ajouter votre commentaire</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name:'PostDetails',
    data(){
        return {
            bodyRequestGetPost:{
                userId : "",
                postId: "",
            },
            post: {},
            user:{},
            likes:{},
            comments:{},
            userId: "",
            addCommentBody:{
                userId:'',
                postId:'',
                content:'',
            },
            deleteCommentBody:{
                userId:'',
                commentId:'',
            },
        }
    },
    methods: {
        deleteMyComment(commentId){
            this.deleteCommentBody.userId = this.userId;
            this.deleteCommentBody.commentId = commentId;
            fetch('http://localhost:3000/api/comments/post/'+ `${commentId}`,{
                method: 'DELETE',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body: JSON.stringify(this.deleteCommentBody),
            })
            .then(response => response.json())
            .then(response => {
                console.log(response);
                this.APIRequest();
            })
        },
        APIRequest(){
            let href = window.location.href;
            let hrefsplit = href.split('/');
            const id = hrefsplit[hrefsplit.length - 1];
            this.bodyRequestGetPost.postId = id;

            fetch('http://localhost:3000/api/posts/'+ `${id}`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body: JSON.stringify(this.bodyRequestGetPost),
            })
            .then(response => response.json())
            .then(posts => {
                let splitDateTime = posts.createdAt.split('T');
                let splitDate = splitDateTime[0].split('-');
                let splitTime = splitDateTime[1].split(':');
                let trueHour = parseInt(splitTime[0])+2; // On rajoute 2 heures pour faire correspondre à l'heure actuelle
                posts.createdAt = 'Créé le ' + splitDate[2] + '/' + splitDate[1] + '/' + splitDate[0] + ' à ' + trueHour + ':' + splitTime[1];
                this.post = Object.values(posts);
                this.comments = posts.Comments;
                this.user = posts.User;
                this.likes = posts.Likes;
                this.post = posts;
            })
        },
        test(){
            console.log('test');
        },
        getUserId(){
            this.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
            this.bodyRequestGetPost.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
        },
        addComment(){
            this.addCommentBody.userId = this.userId;
            this.addCommentBody.postId = this.post.postId;
            console.log(this.addCommentBody);
            let href = window.location.href;
            let hrefsplit = href.split('/');
            const id = hrefsplit[hrefsplit.length - 1];
            fetch('http://localhost:3000/api/comments/post/'+ `${id}`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body: JSON.stringify(this.addCommentBody),
            })
            .then(response => response.json())
            .then(response => {
                console.log(response);
                this.APIRequest();
            })
        }
    },
    mounted(){
        this.getUserId();
        this.APIRequest();
    }
}
</script>

<style>

</style>