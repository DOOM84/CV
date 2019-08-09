
export default {
  mode: 'universal',
  /*
  ** Headers of the page
  */
  router: {
    linkExactActiveClass: 'active',
    scrollBehavior: async (to, from, savedPosition) => {
      if (savedPosition) {
        return savedPosition
      }

      const findEl = async (hash, x) => {
        return document.querySelector(hash) ||
            new Promise((resolve, reject) => {
              if (x > 50) {
                return resolve()
              }
              setTimeout(() => { resolve(findEl(hash, ++x || 1)) }, 100)
            })
      };

      if (to.hash) {
        let el = await findEl(to.hash);
        if ('scrollBehavior' in document.documentElement.style) {
          return window.scrollTo({ top: el.offsetTop, behavior: 'smooth' })
        } else {
          return window.scrollTo(0, el.offsetTop)
        }
      }
      return {x: 0, y: 0}
    }
    },

  head: {
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Arvo:400,700' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900' }
    ],
    script: [

    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    '@/assets/css/index.scss',
    '@/assets/css/bootstrap.min.css',
    '@/assets/css/fontawesome-all.min.css',
    '@/assets/css/style.css',
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    '@/plugins/axios',
    '@/plugins/mixins/validation.js',
    '@/plugins/mixins/locat.js',
    '@/plugins/mixins/lang.js',
    '@/plugins/mixins/toLang.js',
    { src: '~/plugins/back-to-top', mode: 'client' },
    { src: '~plugins/vue-notification'},
    { src: '~plugins/prism'},
    { src: '~/plugins/ckeditor', mode: 'client' }
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/auth',
    'vue-scrollto/nuxt',
    'nuxt-vue-multiselect',
    ['cookie-universal-nuxt', { alias: 'cookiz', parseJSON: false }]
  ],

  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: '/auth/login',
            method: 'post',
            propertyName: 'meta.token'
          },
          user: {
            url: '/auth/me',
            method: 'get',
            propertyName: 'data'
          },
          logout: {
            url: '/auth/logout',
            method: 'post'
          }
        }
      }
    }
  },
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
    baseURL: 'http://cvb.loc/api/'
  },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend(config, ctx) {
      config.resolve.alias['vue'] = 'vue/dist/vue.common'
    }
  }
}
