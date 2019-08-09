<template>
  <div>
    <div class="header-outs-1">
      <header>
        <div class="container-fluid px-lg-5 position-fixed" id="nav">
          <app-nav />
        </div>
      </header>
      <!--banner -->

    </div>
    <nuxt />
    <app-footer />

  </div>
</template>
<script>
  import AppNav from '@/components/nav'
  import AppFooter from '@/components/footer'
  export default {
    components: {AppFooter, AppNav},
    head () {
      return {
        link: [
          { rel: 'stylesheet', href: '/css/single.css' }
        ]
      }
    },
    data(){
      return {
        bg: '',
        f: function(){
          var navbar = document.getElementById("nav");
          var nav_classes = navbar.classList;
          if(document.documentElement.scrollTop >= 150) {
            if (nav_classes.contains("shrink") === false) {
              nav_classes.toggle("shrink");
            }
          }
          else {
            if (nav_classes.contains("shrink") === true) {
              nav_classes.toggle("shrink");
            }
          }
        }
      }
    },
    mounted() {
      this.$nextTick(function(){
        window.addEventListener("scroll", this.f)
      })
    },
    destroyed () {
      if (process.browser) {
        window.removeEventListener('scroll', this.f)
      }
    }
  }
</script>
<style lang="scss" scoped>
  .shrink{
    background: rgba(169,169,169, 0.9);
  }
</style>
