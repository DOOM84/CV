<template>
    <div class="flex-center error-layout">
        <div class="error-content">
            <h1 class="tittle text-center mb-md-5 mb-4">{{getLang(location, 'notFound')}}</h1>
            <nuxt-link to="/">
              {{getLang(location, 'return')}}
            </nuxt-link>
        </div>

    </div>
</template>

<script>
    export default {
        head(){
            return {
                title: this.getLang(this.location, 'notFound')
            }
        }
    }
</script>

<style lang="scss" scoped>
    .error-layout{
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
    }
    .error-content{
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 4rem;
        padding-bottom: 4rem;
    }

    .error-title{
       //color: white;
        margin-bottom: 1rem;
    }

</style>
