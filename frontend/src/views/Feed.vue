<template>
    <div class="flex flex-col justify-center items-center">
        <FormPost />
        <div v-for="post in listPosts" :data-postid="post.postId" class="border rounded-2xl h-auto bg-white w-11/12 m-1 hover:shadow flex flex-col justify-around items-start p-4 max-w-3xl">
            <div :data-userid="post.userId" class="flex justify-around items-start mb-6">
                <div class="bg-gray-900 h-16 w-16 rounded-2xl flex justify-center items-center"><i class="fas fa-user-alt"></i></div>
                <!-- <img src="" alt="Photo de profil de l'utilisateur" class="bg-gray-900 h-16 w-16 rounded-2xl"> -->
                <div class="flex flex-col justify-around items-start m-2">
                    <h2>{{ post.userId }}</h2>
                    <p>{{ post.createdAt }}</p>
                </div>
            </div>
            <p>{{ post.content }}</p>
            <img v-if="post.files" :src="post.files" alt="Image liée au post" class="rounded-2xl my-4 mx-auto">
        </div>
    </div>
</template>

<script>
import FormPost from "@/components/FormPost";
export default {
    name: "Feed",
    components:{
        FormPost,
    },
    data(){
        return {
            listPosts: [],
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
                console.log(posts);
                this.listPosts = Object.values(posts);
                console.log(this.listPosts);
                for (const posts of this.listPosts) {
                    console.log(JSON.stringify(posts.postId));
                }
            });
        },
    },
    beforeMount() {
        this.APIRequest();
    }
}
</script>

<style lang="scss" scoped>
div div i {
  font-size: 3rem;
  line-height: 4rem;
  color: rgb(211, 57, 57);
}
</style>