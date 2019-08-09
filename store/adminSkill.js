export const state = () => ({
});

export const mutations = {

};


export const actions = {

    async index() {
        try {
            return await this.$axios.$get('admin/skill')
        } catch (error) {
            throw error;
        }
    },

    async create({}, data) {
        try {
            return await this.$axios.$post('admin/skill', data)
        } catch (error) {
            throw error;
        }
    },

    async update({}, params){
      try {
            await this.$axios.$patch(`admin/skill/${params.slug}`, params.data)
        } catch (error) {
            throw error;
        }
    },
  async delete({}, slug){

        try {
           return await this.$axios.$delete(`admin/skill/${slug}`);
        } catch (error) {
            throw error;
        }
    }
};

export const getters = {

  };
