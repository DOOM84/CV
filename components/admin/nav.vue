<template>
  <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <notifications group="foo" animation-name="v-fade-left" position="top center" />
    <nuxt-link class="navbar-brand col-sm-3 col-md-2 mr-0" to="/">Главная страница</nuxt-link>
    <ul class="navbar-nav px-3 d-inline">
      <li class="nav-item text-nowrap">
        <button @click.prevent="logout" class="btn btn-link text-white" >Выход</button>
      </li>
    </ul>
  </nav>
</template>

<script>
    export default {
        methods: {
            logout(){
                this.$auth.logout()
            }
        }
    }
</script>

<style scoped>

</style>
