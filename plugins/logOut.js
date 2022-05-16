import {defineNuxtPlugin} from '#app'

export default defineNuxtPlugin(nuxtApp => {
    const user = useUserInfo();
    const isLoggedIn = useLoggedIn();
    const authToken = useTokenAuth();
    const isAdmin = useUserAdmin();
    nuxtApp.provide('logOut', async () => {

        isLoggedIn.value = false;
        authToken.value = false;
        user.value = false;
        isAdmin.value = false;

        await $fetch('/api/signout')

        if (!process.server) {
            document.cookie = 'token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }
    })
})
