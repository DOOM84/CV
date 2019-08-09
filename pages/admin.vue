<template>
    <div>
    <nuxt-child />
    </div>
</template>

<script>
    export default {
        layout: 'admin',
        async asyncData({store}) {
            try {
                await store.dispatch('auth/checkAdmin');

            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
    }
</script>

<style scoped>

</style>
