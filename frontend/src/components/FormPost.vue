<template>
    <form class="flex flex-col justify-between items-center bg-white h-auto w-11/12 m-6 rounded-2xl max-w-3xl">
    <div class="flex justify-between items-start w-full p-1">
        <div class="bg-gray-900 h-16 w-16 rounded-2xl flex justify-center items-center">
            <i class="fas fa-user-alt "></i>
        </div>
        <div class="h-full w-9/12 p-1">
            <textarea id="content" type="text" placeholder="Quoi de neuf ?" class="w-full h-full rounded p-1 focus:border-red-600 focus:border" />
        </div>
    </div>
    <div class="flex justify-between items-center w-full p-1">
        <label for="file" class=" cursor-pointer bg-red-700 rounded-2xl px-1 py-2 text-center text-white h-10 w-6/12">Ajouter une image</label>
        <input id="file" type="file" accept="image/png, image/jpeg, image/jpg" class="hidden"/>
        <button @click="sendPost" type="button" class="bg-red-700 rounded-2xl text-center m-1 text-white h-10 w-4/12">Envoyez !</button>
    </div>
    </form>
</template>

<script>
export default {
    name:'FormPost',
    data(){
        return {
            post:{
<<<<<<< HEAD
<<<<<<< HEAD
                userId:JSON.parse(localStorage.getItem('authgroupomania')).userId,
                content:"",
=======
=======
>>>>>>> parent of c8e79af (Responsive)
                userId:null,
                content:null,
>>>>>>> parent of c8e79af (Responsive)
                files:null
            }
        }
    },
    methods:{
        sendPost(){
            let content = document.querySelector('#content').value;
            console.log(content);
            this.post.content = content;
            this.post.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId
            fetch('http://localhost:3000/api/posts',{
                method: 'POST',
                headers: {
                    'Authorization' : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json' 
                },
                body: JSON.stringify(content)
            })
            .then(response => response.json())
            .then(response => {
                console.log(response);
            })
        }
    },
}
</script>

<style lang="scss" scoped>
div i {
  font-size: 3rem;
  line-height: 4rem;
  color: rgb(211, 57, 57);
}
.inputfile {
	width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
}
textarea {
    outline:none;
}
</style>