<template>
    <div>

    <!-- //banner -->
    <section class="banner-bottom-w3layouts py-lg-5 py-md-5 py-3">
        <div class="container">
            <div class="inner-sec-w3ls-agileits py-lg-5 py-3">
                <h1 class="tittle text-center">{{getLang(location, 'blog')}}</h1>
                <div class="row py-lg-5">
                    <!--left-->
                    <div class="col-lg-8 left-blog-info text-left">
                        <div class="row news-grids text-center">
                            <div v-for="post in posts" :key="post.id" class="col-md-4 mb-3">
                                <nuxt-link :to="post.path">
                                    <img :src="post.image" alt="news image" class="img-fluid">
                                </nuxt-link>
                                <nuxt-link :to="post.path"><h6>{{post.title}}</h6></nuxt-link>
                                <p class="mt-4 "><nuxt-link :to="post.path">
                                    {{post.subtitle}}
                                </nuxt-link></p>
                            </div>
                        </div>

                      <template v-if="postPages > 1">
                        <ul class="pagination justify-content-center mt-5">
                          <li :class="{'page-item': true, 'disabled': page === 1}">
                            <button @click="prevPage" class="page-link" tabindex="-1" aria-disabled="true">&laquo;</button>
                          </li>
                          <li v-for="p in postPages" :class="{'page-item': true, 'active': p === page}">
                            <button @click="changePage(p)" class="page-link " tabindex="-1" aria-disabled="true">{{p}}</button>
                          </li>
                          <li :class="{'page-item': true, 'disabled': page === postPages}">
                            <button @click="nextPage" class="page-link">&raquo;</button>
                          </li>
                        </ul>
                      </template>

                    </div>

                    <!--//left-->
                    <!--right-->
                    <app-aside :posts="recentPosts" :categories="categories"/>
                    <!--//right-->
                </div>

            </div>
        </div>
    </section>
    <!--/single-->
    <!-- contact -->

    </div>
</template>

<script>
    import AppAside from '@/components/aside'
    export default {
components: {AppAside},
        head(){
            return {
                title: this.getLang(this.location, 'sphere') + ' — ' + this.getLang(this.location, 'blog')
            }
        },
        data() {
            return {
                recentPosts: '',
                categories: '',
                posts: '',
                page: 1,
                postPages: 0
            }
        },
        async asyncData({store}) {
            try {
                const {recentPosts} = await store.dispatch('home/posts');
                const {categories} = await store.dispatch('home/categories');
                const {posts, postPages} = await store.dispatch('blog/posts');
                return {
                    recentPosts,
                    categories,
                    posts,
                    postPages
                }
            }
            catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            async changePage(page){
                this.page = page;
                const {posts} = await this.$store.dispatch('blog/posts', this.page);
                this.posts = posts
            },
            async prevPage(){
                this.page--;
                if(this.page < 1){this.page++; return false}
                const {posts} = await this.$store.dispatch('blog/posts', this.page);
                this.posts = posts
            },
            async nextPage(){
                this.page++;
                if(this.page > this.postPages){this.page--; return false}
                const {posts} = await this.$store.dispatch('blog/posts', this.page);
                this.posts = posts
            },
        }

    }
</script>

<style scoped>

</style>
