<template>
  <div class="main bg-gray-100">
    <Header/>
    <div class="flex justify-center items-start m-auto lg:w-9/12 relative">
      <NavDesktop @displayLoading="$store.commit('displayLoading')"/>
      <router-view />
    </div>
  </div>
</template>

<script>
import Header from "@/components/Header.vue";
import store from "@/store/index";
import NavDesktop from "@/components/NavDesktop.vue";

export default {
  name: "Main",
    components:{
    Header,
    NavDesktop,
  },
  data(){
    return{

    }
  },
  methods:{
  },
  beforeCreate() {
    this.$options.components.Header = require('../components/Header.vue').default;
    this.$options.components.NavDesktop = require('../components/NavDesktop.vue').default;
  },
  created(){
    store.commit('checkValidation');
  }
}
</script>

<style lang="scss" scoped>
</style> 