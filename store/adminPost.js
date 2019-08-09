export const state = () => ({
  comments: null
});

export const mutations = {
  SET_COMMENTS(state, data) {
    state.comments = data
  }
};


export const actions = {

    async index() {
        try {
            return await this.$axios.$get('admin/post')
        } catch (error) {
            throw error;
        }
    },

  async edit() {
    try {
      return await this.$axios.$get('admin/post/edit')
    } catch (error) {
      throw error;
    }
  },

    async create({}, data) {
        try {
            return await this.$axios.$post('admin/post', data)
        } catch (error) {
            throw error;
        }
    },

    async update({}, params){
      try {
            await this.$axios.$post(`admin/post/${params.slug}`, params.data, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
            })
        } catch (error) {
            throw error;
        }
    },

    async delCom({}, data){
        try {
            return await this.$axios.$delete(`admin/comment/${data.comment}/${data.post}/del`);
        } catch (error) {
            throw error;
        }
    },

  async delete({}, post){

        try {
           return await this.$axios.$delete(`admin/post/${post}`);
        } catch (error) {
            throw error;
        }
    }
};

export const getters = {
  comments(state){
    return state.comments
  }
};
