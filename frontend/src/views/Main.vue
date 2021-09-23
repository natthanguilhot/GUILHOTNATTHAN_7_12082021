<template>
  <div class="main bg-gray-100">
    <Header />
    <h1>This is the main page</h1>
  </div>
</template>

<script>
import Header from "@/components/Header.vue";
export default {
  name: "Main",
    components:{
    Header,
  },
  data(){
    return{

    }
  },
  beforeCreate() {
    this.$options.components.Header = require('../components/Header.vue').default;
  },

}
</script>

<style>

</style>
