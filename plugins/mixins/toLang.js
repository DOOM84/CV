import Vue from 'vue'

Vue.mixin({
    methods: {
      toLang(param){
        return this.location !== 'ru' ? this.location+'_'+param : param
      }
    }
});
