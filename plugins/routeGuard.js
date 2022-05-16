//import { useState } from '#app';

export default defineNuxtPlugin(async ({ssrContext, $logOut}) => {
    const router = useRouter();
    const user = useUserInfo();
    const authToken = useTokenAuth();
    const isLoggedIn = useLoggedIn();
    const isAdmin = useUserAdmin();

    if (process.server && ssrContext) {

        const {res, url} = ssrContext;
        const {path} = router.resolve(url);



        const toName = path.split("/");


            if (toName[1] === 'blog') {

                try {

                    const data = await $fetch('/api/user', {
                        headers: useRequestHeaders(["cookie"]),
                    });


                    if (data) {
                        user.value = {
                            name: data.login,
                            avatar: data.avatar
                        };
                        isLoggedIn.value = true;
                    } else {
                        $logOut();
                    }

                } catch (e) {
                    $logOut();
                }
            }

            if ((toName[1] === 'auth')) {
                    try {

                        const data = await $fetch('/api/user', {
                            headers: useRequestHeaders(["cookie"]),
                        });

                        if (data) {
                            ssrContext.res.writeHead(302, {Location: '/'});
                            ssrContext.res.end();
                        }

                    } catch (e) {
                        //console.log(e);
                    }
            }

        if ((toName[1] === 'search')) {
            ssrContext.res.writeHead(302, {Location: '/'});
            ssrContext.res.end();
        }

            if ((toName[1] === 'admin')) {
                try {

                    const {access} = await $fetch('/api/check', {
                        headers: useRequestHeaders(["cookie"]),
                    });

                    if (!access) {
                        await Promise.reject(Error());
                    } else {
                        isAdmin.value = true;
                    }

                } catch (e) {
                    ssrContext.res.writeHead(302, {Location: '/404'});
                    ssrContext.res.end();
                    //console.log(e);
                }
            }
    } else if (process.client) {
        router.beforeEach(async (to, from, next) => {

            const toName = to.path.split("/");

            if (!user.value && authToken.value) {
                if (toName[1] === 'blog') {
                    try {

                        const data = await $fetch('/api/user')

                        if (data) {
                            user.value = {
                                name: data.login,
                                avatar: data.avatar
                            };
                            isLoggedIn.value = true;
                        }

                    } catch (e) {

                        $logOut();
                    }
                }
            }

            if ((toName[1] === 'admin')) {
                try {
                    if (!authToken.value) {
                        return next('/404');
                    }

                    const {access} = await $fetch('/api/check')

                    if (!access) {
                        return next('/404');
                    } else {
                        isAdmin.value = true;
                        return next()
                    }

                } catch (e) {
                    return next('/404');
                    //console.log(e);
                }
            }

            if (toName[1] === 'auth' && isLoggedIn.value) {
                return next('/');
            }

            return next();

        });
    }
});
