import Vue from 'vue';
import {mapGetters} from 'vuex';

const Location = {
    install(Vue, options) {
        Vue.mixin({
            computed: {
                ...mapGetters({
                    location : 'auth/location',
                })
            }
        })
    }
};

Vue.use(Location);