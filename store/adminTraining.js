export const state = () => ({
});

export const mutations = {

};


export const actions = {

    async index() {
        try {
            return await this.$axios.$get('admin/training')
        } catch (error) {
            throw error;
        }
    },

    async create({}, data) {
        try {
            return await this.$axios.$post('admin/training', data)
        } catch (error) {
            throw error;
        }
    },

    async update({}, params){
      try {
            await this.$axios.$patch(`admin/training/${params.id}`, params.data)
        } catch (error) {
            throw error;
        }
    },
  async delete({}, id){

        try {
           return await this.$axios.$delete(`admin/training/${id}`);
        } catch (error) {
            throw error;
        }
    }
};

export const getters = {

  };
