import {defineNuxtPlugin, useState} from '#app';
import getCookie from '../helpers/getCookie';

export default defineNuxtPlugin(({ssrContext}) => {
    let loc;
    const locales = ['ua', 'en', 'ru'];
    if (process.server) {
        loc = getCookie(ssrContext.req.headers.cookie, 'loc');
        loc = (loc && locales.includes(loc)) ? loc : 'ua'

         useState(
            'locale',
            () => loc
        )
    }


})
