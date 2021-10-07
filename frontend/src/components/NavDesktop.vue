<template>
    <nav class="hidden lg:block min-w-[210px] w-3/12 max-w-sm h-auto bg-white rounded-2xl mt-6 border">
      <ul class="flex flex-col justify-around items-start h-auto w-full text-2xl py-4">
        <li class="h-10 hover:bg-primary hover:text-white group w-full">
            <router-link  class="!w-full h-full" to="/main/feed">
                <i class="fas fa-home mx-2 w-7 text-primary group-hover:text-white"></i>
                Fil d'actualités
            </router-link>
        </li>
        <li class="h-10 hover:bg-primary hover:text-white group w-full">
            <router-link  class="!w-full h-full" to="/main/profil">
                <i class="fas fa-user mx-2 w-7 text-primary group-hover:text-white"></i>
                Profil
            </router-link>
        </li>
        <li class="h-10 hover:bg-primary hover:text-white group w-full">
            <router-link  class="!w-full h-full" to="/main/settings">
                <i class="fas fa-user-cog mx-2 w-7 text-primary group-hover:text-white"></i>
                Paramètres
            </router-link>
        </li>
        <li class="h-10 hover:bg-primary hover:text-white group w-full">
            <router-link @click="logOut" class="!w-full h-full" to="/">
                <i class="fas fa-sign-out-alt mx-2 w-7 text-primary group-hover:text-white"></i>
                Deconnexion
            </router-link>
        </li>
      </ul>
    </nav>
</template>

<script>
export default {
    name:'NavDesktop',
    methods:{
        logOut(){
            localStorage.clear('authgroupomania');
        },
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