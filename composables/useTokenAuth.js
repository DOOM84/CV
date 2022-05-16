import {useState} from '#app';
//import { useNuxtApp } from '#app';
import getCookie from "~/helpers/getCookie";
//const {ssrContext} = useNuxtApp();


export const useTokenAuth = () => {
    return useState('tokenAuth', () => {

        const {ssrContext} = useNuxtApp();

        if(ssrContext){return getCookie(ssrContext.req.headers.cookie, 'token')}

        if(process.client){
            return  getCookie(document.cookie, 'token')
        }
        return false
    })
}