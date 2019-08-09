<template>
<div v-if="showAdm">
<admin-nav  />
  <div class="container-fluid">
    <div class="row">
      <nav class="col-md-2 col-lg-2 <!--d-none--> d-md-block bg-light sidebar">
      <admin-aside role='navigation' />
      </nav>
      <main role="main" class="col-md-10 ml-sm-auto col-lg-10 px-4">
      <nuxt  />
      </main>
    </div>
  </div>
</div>
</template>

<script>
    import AdminNav from '@/components/admin/nav'
    import AdminAside from '@/components/admin/aside'
    export default {
        components: {AdminNav, AdminAside},
        head () {
            return {
                link: [
                    { rel: 'stylesheet', href: '/css/dashboard.css' }
                ]
            }
        },
        computed: {
            showAdm(){
                return this.$store.state.auth.isAdmin === 1 ? this.$store.state.auth.isAdmin : false
            }
        },
        beforeMount() {
            if (this.$store.state.auth.isAdmin !== 1) this.$router.push('/404')
        }
    }
</script>

<style lang="scss" scoped>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
</style>
