<template>
    <div class="hidden lg:block min-w-[210px] w-3/12 max-w-sm h-auto rounded-2xl mt-6">
        <div class="bg-white rounded-2xl border p-4 flex justify-start items-center">
            <img :src="$store.state.user.profile_picture" alt="Votre photo de profil" class="h-16 w-16 rounded-2xl object-cover">
            <h1 class="ml-2">{{$store.state.user.name}} {{ $store.state.user.lastname }}</h1>
        </div>
        <nav class="hidden lg:block min-w-[210px] w-full max-w-sm h-auto bg-white rounded-2xl mt-6 border">
        <ul class="flex flex-col justify-around items-start h-auto w-full text-2xl py-4">
            <li class="h-10 hover:bg-primary hover:text-white group w-full">
                <router-link  class="!w-full h-full" :to="{name : 'Feed'}">
                    <i class="fas fa-home mx-2 w-7 text-primary group-hover:text-white"></i>
                    Fil d'actualités
                </router-link>
            </li>
            <li class="h-10 hover:bg-primary hover:text-white group w-full">
                <router-link  class="!w-full h-full" :to="{name: 'Profil'}">
                    <i class="fas fa-user mx-2 w-7 text-primary group-hover:text-white"></i>
                    Profil
                </router-link>
            </li>
            <li class="h-10 hover:bg-primary hover:text-white group w-full">
                <router-link  class="!w-full h-full" :to="{name: 'Settings'}">
                    <i class="fas fa-user-cog mx-2 w-7 text-primary group-hover:text-white"></i>
                    Paramètres
                </router-link>
            </li>
            <li class="h-10 hover:bg-primary hover:text-white group w-full">
                <router-link @click="logOut" class="!w-full h-full" :to="{name: 'Home'}">
                    <i class="fas fa-sign-out-alt mx-2 w-7 text-primary group-hover:text-white"></i>
                    Deconnexion
                </router-link>
            </li>
        </ul>
        </nav>
    </div>
</template>

<script>
export default {
    name:'NavDesktop',
        data(){
        return {
            user:{
                name: "",
                lastname:'',
                pp: "",
                account_type: "",
            },
            bodyUserId:{
                userId:JSON.parse(localStorage.getItem('authgroupomania')).userId,
            },
        }
    },
    methods:{
        logOut(){
            localStorage.clear('authgroupomania');
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
                this.user.account_type = user.account_type;
            })
            .catch(err => err.json())
        },
    },
    beforeMount(){
        this.getUserInformations();
    },
}
</script>

<style lang="scss" scoped>
// nav ul li i {
//   font-size: 0.8rem;
//   line-height: 1rem;
//   color: rgb(200, 60, 60);
// }
</style> 