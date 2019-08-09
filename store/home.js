export const state = () => ({
  exp: '',
  edu: '',
  skills: '',
  projects: '',
  cur_posts: '',
});

export const mutations = {
  SET_EXP(state, data) {
    state.exp = data;
  },
  SET_EDU(state, data) {
    state.edu = data;
  },
  SET_SKILLS(state, data) {
    state.skills = data;
  },
  SET_PROJECTS(state, data) {
    state.projects = data;
  },
  SET_POSTS(state, data) {
    state.cur_posts = data;
  }
};


export const actions = {

  async exp({commit}) {
    try {
      let exp;
      exp = await this.$axios.$get('exp');
      commit('SET_EXP', exp);
      return exp;
    } catch (error) {
      throw error;
    }
  },
  async edu({commit}) {
    try {
      let edu;
      edu = await this.$axios.$get('edu');
      commit('SET_EDU', edu);
      return edu;
    } catch (error) {
      throw error;
    }
  },
  async skills({commit}) {
    try {
      let skills;
      skills = await this.$axios.$get('skills');
      commit('SET_SKILLS', skills);
      return skills;
    } catch (error) {
      throw error;
    }
  },
  async projects({commit}) {
    try {
      let projects;
      projects = await this.$axios.$get('projects');
      commit('SET_PROJECTS', projects);
      return projects;
    } catch (error) {
      throw error;
    }
  },
  async posts({commit}) {
    try {
      let posts;
      posts = await this.$axios.$get('recentPosts');
      commit('SET_POSTS', posts);
      return posts;
    } catch (error) {
      throw error;
    }
  },
  async categories() {
    try {
      return await this.$axios.$get('categories');
    } catch (error) {
      throw error;
    }
  }
};

export const getters = {
  exp(state) {
    return state.exp
  },
  edu(state) {
    return state.edu
  },
  skills(state) {
    return state.skills
  },
  projects(state) {
    return state.projects
  },
  cur_posts(state) {
    return state.cur_posts
  }
};
