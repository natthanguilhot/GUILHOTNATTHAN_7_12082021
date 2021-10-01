<template>
  <div class="main bg-gray-100">
<<<<<<< HEAD
    <Header/>
    <div class="flex justify-center items-start m-auto lg:w-9/12 relative">
      <NavDesktop />
      <router-view />
    </div>
=======
  <header class="border-b shadow-sm">
    <nav>
      <ul class="flex justify-around items-center h-20">
        <li><router-link to="/main/feed"><i class="fas fa-home"></i></router-link></li>
        <li><router-link to="/main/profil"><i class="fas fa-user"></i></router-link></li>
        <li><router-link to="/main/settings"><i class="fas fa-user-cog"></i></router-link></li>
      </ul>
    </nav>
  </header>
  <router-view />
>>>>>>> parent of c8e79af (Responsive)
  </div>
</template>

<script>
import Header from "@/components/Header.vue";
import store from "@/store/index";

export default {
  name: "Main",
    components:{
    Header,
  },
  data(){
    return{

    }
  },
  methods:{
  },
  beforeCreate() {
    this.$options.components.Header = require('../components/Header.vue').default;
  },
  created(){
    store.commit('checkValidation');
  }
}
</script>

<style lang="scss" scoped>
header nav ul li i {
  font-size: 3rem;
  line-height: 4rem;
  color: rgb(200, 60, 60);
}
</style> 