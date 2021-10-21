<template>
  <header class="border-b shadow-sm">
    <router-link to="/main/feed"><img src="../assets/icon-removebg-preview.png" alt="Groupomania" class="hidden lg:block h-[73px] top-1 left-1 absolute"/></router-link>
    <div class="flex justify-center items-center h-10 max-w-3xl m-auto pt-8 mb-8">
      <!-- TODO : Ajouter img du compte de l'utilisateur -->
      <div class="bg-gray-900 h-10 w-10 rounded-2xl flex justify-center items-center m-1"><i class="fas fa-user-alt text-primary"></i></div>
      <input type="text" class="h-10 m-1 w-9/12 pl-2 rounded-2xl" />
      <button class="text-2xl flex justify-center items-center text-primary cursor-pointer"><i class="fas fa-search"></i></button>
    </div>
    <nav class="lg:hidden">
      <ul class="flex justify-around items-center h-20">
        <li><router-link to="/main/feed" aria-label="Fil d'actualités"><i class="fas fa-home"></i></router-link></li>
        <li><router-link to="/main/profil" aria-label="Profil"><i class="fas fa-user"></i></router-link></li>
        <li><router-link to="/main/settings" aria-label="Paramètres"><i class="fas fa-user-cog"></i></router-link></li>
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
  @apply text-primary
}
</style> 