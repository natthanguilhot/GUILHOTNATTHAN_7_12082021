<template>
  <header class="border-b shadow-sm">
    <div class="flex justify-center items-center h-10 max-w-3xl m-auto pt-8 mb-8">
      <div class="bg-gray-900 h-10 w-10 rounded-2xl flex justify-center items-center m-1"><i class="fas fa-user-alt text-red-600"></i></div>
      <input type="text" class="h-10 m-1 w-9/12 pl-2 rounded-2xl" />
      <button class="text-2xl flex justify-center items-center text-red-600 cursor-pointer"><i class="fas fa-search"></i></button>
    </div>
    <nav class="lg:hidden">
      <ul class="flex justify-around items-center h-20">
        <li><router-link to="/main/feed"><i class="fas fa-home"></i></router-link></li>
        <li><router-link to="/main/profil"><i class="fas fa-user"></i></router-link></li>
        <li><router-link to="/main/settings"><i class="fas fa-user-cog"></i></router-link></li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
    name:"Header"
}
</script>

<style lang="scss" scoped>
header nav ul li i {
  font-size: 3rem;
  line-height: 4rem;
  color: rgb(200, 60, 60);
}
</style> 