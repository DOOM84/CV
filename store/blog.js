export const state = () => ({

});

export const mutations = {

};


export const actions = {

  async posts({}, page=1) {
    try {
      return await this.$axios.$get(`posts/${page}`);
    } catch (error) {
      throw error;
    }
  },
  async post({}, data) {
    try {
      return await this.$axios.$get(`post/${data}`);
    } catch (error) {
      throw error;
    }
  },
  async category({}, data) {
    try {
      return await this.$axios.$get(`category/${data.slug}/${data.page}`);
    } catch (error) {
      throw error;
    }
  },

  async search({}, data) {
    try {
      return await this.$axios.$get(`search/${data}`);
    } catch (error) {
      throw error;
    }
  },
};

export const getters = {

};
