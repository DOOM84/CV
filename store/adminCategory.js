export const state = () => ({
});

export const mutations = {

};


export const actions = {

    async index() {
        try {
            return await this.$axios.$get('admin/category')
        } catch (error) {
            throw error;
        }
    },

    async create({}, data) {
        try {
            return await this.$axios.$post('admin/category', data)
        } catch (error) {
            throw error;
        }
    },

    async update({}, params){
      try {
            await this.$axios.$patch(`admin/category/${params.slug}`, params.data)
        } catch (error) {
            throw error;
        }
    },
  async delete({}, slug){

        try {
           return await this.$axios.$delete(`admin/category/${slug}`);
        } catch (error) {
            throw error;
        }
    }
};

export const getters = {

  };
