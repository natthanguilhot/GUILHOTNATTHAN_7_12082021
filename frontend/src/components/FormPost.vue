<template>
    <form id="formAddPost" class="flex flex-col justify-between items-center bg-white h-auto w-11/12 my-6 lg:mx-8 p-3 rounded-2xl max-w-3xl border">
        <div class="flex justify-between sm:justify-start items-start w-full p-1">
            <div class="bg-gray-900 h-16 w-16 rounded-2xl flex justify-center items-center">
                <img :src="user.pp" alt="PP de l'utilisateur" class="bg-gray-900 h-16 w-16 rounded-2xl object-cover">
            </div>
            <div class="h-full w-9/12 sm:w-full p-1">
                <label for="content">Partagez avec vos collègues :</label>
                <textarea v-model="post.content" name="content" id="content" type="text" :placeholder="'Quoi de neuf ' + user.name + ' ?'" minlength="1" required="required" class="w-full h-full rounded p-1 focus:border-red-600 focus:border" />
            </div>
        </div>
        <img v-if="file" id="myimage" src="" alt="Prévisualisation de votre fichier" class="rounded-2xl">
        <div class="flex justify-between items-center w-full p-1">
            <label for="file" class="cursor-pointer bg-primary rounded-2xl px-1 py-1 text-center text-white h-10 w-5/12 max-w-[120px] hover:opacity-75">GIF/JGP/PNG</label>
            <input @change="onFileSelected" id="file" name="file" type="file" accept="image/png, image/jpeg, image/jpg" class="w-0 h-0"/>
            <button @click.prevent="sendPost" type="submit" class="bg-primary rounded-2xl text-center m-1 text-white h-10 w-4/12">Envoyez !</button>
        </div>
        <p v-if="response" class="text-green-600">{{ response }}</p>
    </form>
</template>

<script>
export default {
    name:'FormPost',
    data(){
        return {
            post:{
                userId: JSON.parse(localStorage.getItem('authgroupomania')).userId,
                content:"",
                files:null
            },
            response:'',
            user:{
                name: "",
                lastname:'',
                pp: "",
            },
            bodyUserId:{
                userId: JSON.parse(localStorage.getItem('authgroupomania')).userId,
            },
            file: false,
        }
    },
    methods:{
        switchThisFile(valeur){
            this.file = valeur;
        },
        sendPost(){
            var formdata = new FormData();
            const inputFile = document.querySelector('#file');
            if(!inputFile.files[0] && this.post.content == ''){
                this.response = "Veuillez remplir le formualire !"
                setTimeout(() => {
                    this.response = '';
                }, 2250);
            } else {
                formdata.append("userId", this.post.userId);
                formdata.append("content", this.post.content);
                formdata.append("files", inputFile.files[0]);
                fetch('https://groupomania-17379.nodechef.com/api/posts',{
                    method: 'POST',
                    headers: {
                        'Authorization' : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                    },
                    body: formdata,
                })
                .then(response => response.json())
                .then(response => {
                    this.switchThisFile(false);
                    this.$emit('MajPost'); // Emet l'evenement qui met à jour la vue
                    this.post.content = "",
                    this.response = response.message;
                    let imgtag = document.getElementById("myimage");
                    imgtag.src = null;
                    let file = document.querySelector('#file');
                    file.value = null;
                    setTimeout(() => {
                        this.response = null;
                    }, 3000);
                })
            }
        },
        onFileSelected(event) {
            this.switchThisFile(true);
            setTimeout(() => {
                var selectedFile = event.target.files[0];
                var reader = new FileReader();
                var imgtag = document.getElementById("myimage");
                imgtag.title = selectedFile.name;
                reader.onload = function(event) {
                    imgtag.src = event.target.result;
                };
                reader.readAsDataURL(selectedFile);
            }, 100);
        },
        getUserInformations(){
            fetch('https://groupomania-17379.nodechef.com/api/auth/user/' + `${this.bodyUserId.userId}`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json', 
                    'Content-Type': 'application/json',
                    "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
                },
                body : JSON.stringify(this.bodyUserId),
            })
            .then(response => response.json())
            .then(user => {
                this.user.name = user.name;
                this.user.lastname = user.lastname;
                this.user.pp = user.profile_picture;
            })
            .catch(err => err.json())
        },
    },
    beforeMount(){
        this.getUserInformations();
    }
}
</script>

<style lang="scss" scoped>
div i {
  font-size: 3rem;
  line-height: 4rem;
  color: #FD2D01;
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
label i {
    font-size: 1rem;
    line-height: 1rem;
    color: white;
}
</style>