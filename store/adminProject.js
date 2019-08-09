export const state = () => ({
});

export const mutations = {

};


export const actions = {

    async index() {
        try {
            return await this.$axios.$get('admin/project')
        } catch (error) {
            throw error;
        }
    },

  async edit() {
    try {
      return await this.$axios.$get('admin/project/edit')
    } catch (error) {
      throw error;
    }
  },

    async create({}, data) {
        try {
            return await this.$axios.$post('admin/project', data)
        } catch (error) {
            throw error;
        }
    },

    async update({}, params){
      try {
            await this.$axios.$post(`admin/project/${params.id}`, params.data, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
            })
        } catch (error) {
            throw error;
        }
    },
  async delete({}, id){

        try {
           return await this.$axios.$delete(`admin/project/${id}`);
        } catch (error) {
            throw error;
        }
    }
};

export const getters = {

  };
