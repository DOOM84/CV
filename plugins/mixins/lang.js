import Vue from 'vue'
import Lang from '@/static/js/lang'

Vue.mixin({
    methods: {
        getLang (loc,key) {
            if(loc === 'en' || loc === 'ua' || loc === 'ru'){
                return Lang[loc][key]
            }
            return Lang['ua'][key]
        }
    }
});
