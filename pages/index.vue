<template>
  <div>
    <!-- //banner -->
    <!-- news -->
    <section class="news py-5" id="about">
      <app-about :exp="exp" :edu="edu" :age="age"/>
    </section>
    <!-- //news -->
    <!-- ban_bottom -->
    <section class="ban_bottom1 py-5" id="more">
      <div class="container py-lg-5">
        <div class="ban_bottom_top text-left py-lg-5 text-white">
          <h1 class="tittle text-white">{{getLang(location, 'quote')}}</h1>
          <h1 class="text-right tittle text-white">{{getLang(location, 'quote_author')}}</h1>
        </div>
      </div>
    </section>
    <!-- //ban_bottom -->
    <!-- services -->
    <section class="services py-5" id="technologies">
      <app-technologies :skills="skills"/>
    </section>
    <!-- //services -->
    <!-- Gallery -->
    <section class="gallery py-5 projects" id="projects">
      <app-projects :projects="projects"/>

    </section>
    <!-- blog -->
    <section class="blog_w3l py-5" id="blog">
      <app-blog :posts="recentPosts"/>
    </section>
    <!-- //blog -->

  </div>
</template>

<script>
    import AppAbout from '@/components/about';
    import AppTechnologies from '@/components/technologies';
    import AppProjects from '@/components/projects';
    import AppBlog from '@/components/blog';

    export default {
        components: {AppAbout, AppTechnologies, AppProjects, AppBlog},
        layout: 'home',
        head(){
            return {
                title: this.getLang(this.location, 'sphere') + ' — ' + this.getLang(this.location, 'welcome')+'!'
            }
        },
        data: function () {
            return {
                age: '',
                exp: '',
                edu: '',
                skills: '',
                projects: '',
                recentPosts: ''
            }
        },
        async asyncData({store}) {
            try {
                if (!store.getters['home/exp']) {
                    const {exp, age} = await store.dispatch('home/exp');
                    const {edu} = await store.dispatch('home/edu');
                    const {skills} = await store.dispatch('home/skills');
                    const {projects} = await store.dispatch('home/projects');
                    const {recentPosts} = await store.dispatch('home/posts');
                    return {
                        exp: exp,
                        age: age,
                        edu: edu,
                        skills: skills,
                        projects: projects,
                        recentPosts: recentPosts
                    }
                }
            } catch (error) {
                if (error.response.status === 401) {
                    return $nuxt.$router.replace('/login');
                }
            }
        }
    }
</script>

<style lang="scss" scoped>
  .projects {
    //background-attachment: fixed !important;
    background-image: linear-gradient(120deg, #8e9eab 0%, #eef2f3 100%);
  }
</style>
