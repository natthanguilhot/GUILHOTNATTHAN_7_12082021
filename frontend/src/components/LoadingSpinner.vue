<template>
  <div>
      <div class="fixed h-screen w-full bg-gray-600 opacity-80 inset-0 z-40"></div>
      <div class="fixed inset-x-0 inset-y-2/4 mx-auto h-36 w-36 bg-gray-100 rounded flex justify-center items-center opacity-100 z-50">
        <div class="h-20 w-20 border-t border-primary rounded-full animate-spin p-2"><img src="../assets/icon.png" alt="Groupomania" class="rounded-full"/></div>
      </div>
  </div>
</template>

<script>
export default {
    name: "LoadingSpinner",
}
</script>

<style lang="scss" scoped>
</style>