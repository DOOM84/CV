import Cookie from 'cookie';
export const state = () => ({
    busy: false,
    loggedIn: false,
    strategy: "local",
    user: false,
    location: 'ua',
    isAdmin: null,
    answer: null,
    addedAnswer: null,
});

export const mutations = {
    SET_LOCATION(state, data){
        state.location = data
    },
    SET_ADMIN(state, data){
        state.isAdmin = data
    },
    SET_ANSWER(state, data){
        state.answer = data;
    },
    SET_ADDED_ANSWER(state, data){
        state.addedAnswer = data;
    }

};


export const actions = {
    setLang({commit}){

    const cookieStr = process.browser ? document.cookie : this.app.context.req.headers.cookie;

    const cookies = Cookie.parse(cookieStr || '') || {};

    const lang = cookies['lang'];

        if(!lang){
          this.$cookiz.set('lang', 'ua', {maxAge: 60 * 60 * 24 * 30});
          commit('SET_LOCATION', 'ua')
    }else{
          commit('SET_LOCATION', lang)
        }

},
    setLocation({commit},lang){
        commit('SET_LOCATION', lang)
    },

    async checkAdmin({commit}) {
        try {
            const adm = await this.$axios.$get('checkAdmin');
            commit('SET_ADMIN', adm);
            return adm;

        } catch (error) {
            throw error;
        }

    },

  async addAvatar({}, data){

    try {
      return await this.$axios.$post('addAvatar', data, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
    }catch (error) {
      throw error;
    }
  },

  async contact({}, data){
    try {
      return await this.$axios.$post('contact', data);
    }catch (error) {
      throw error;
    }

  },

  async restore({}, data){
    try {
      return await this.$axios.$post('getPass', data);
    }catch (error) {
      throw error;
    }

  },

  async rate({}, data){
    try {
      return await this.$axios.$post('rate', data);
    }catch (error) {
      throw error;
    }
  },

  async comment({}, data){
    try {
      return await this.$axios.$post('comment', data);
    }catch (error) {
      throw error;
    }
  }


};

export const getters = {

    location(state){
        return state.location
    },
    isAdmin(state){
        return state.isAdmin
    },
    answer(state){
    return state.answer
    },

    addedAnswer(state){
    return state.addedAnswer
    }
};

