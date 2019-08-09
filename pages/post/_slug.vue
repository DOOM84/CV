<template>
    <div>
        <!-- //banner -->
        <section class="banner-bottom-w3layouts py-lg-5 py-md-5 py-3">
            <div class="container">
                <div class="inner-sec-w3ls-agileits py-lg-5 py-3">
                    <h1 class="tittle text-center mb-md-5 mb-4">
                      <nuxt-link to="/blog">{{getLang(location, 'blog')}}</nuxt-link> / <nuxt-link v-for="category in post.categories" :key="category.slug" style="color: #777" :to="'/blog/category/' + category.slug">
                        {{category[toLang('name')]}}
                      </nuxt-link>
                    </h1>
                    <div class="row mt-5 py-lg-5">
                        <!--left-->
                        <div class="col-lg-8 left-blog-info text-left">
                            <div class="blog-grid-top">
                                <div class="b-grid-top">
                                    <div class="blog_info_left_grid">
                                            <img :src="post.image" class="img-fluid" alt="">
                                    </div>
                                </div>
                              <div class="sub-meta text-right">
                                <span class="fa fa-pencil pr-2"> {{post.author}}</span>
                                <span class="fa fa-clock-o pr-2"> {{post.date}}</span>
                                <button :disabled="!$auth.loggedIn" @click="ratePost" class="p-0 m-0 btn btn-link">
                                  <span style="color: red" class="p-0 m-0 fa fa-heart pr-2"> {{post.rate}}</span>
                                </button >
                              </div>
                                <h3>
                                    {{post.title}}
                                </h3>
                                <div v-html="post.text"></div>
                              <div class="sub-meta text-right">
                                <span><a target="_blank" :href="post.source">{{getLang(location, 'source')}}</a></span>
                              </div>
                            </div>
                            <div class="comment-top">

                              <comments  v-if="post.comments"  :comments="post.comments" :id="'root'"/>

                            </div>
                            <comment-form v-if="$auth.loggedIn" :postId="post.id" id="commentForm" />
                            <p v-else>{{getLang(location, 'can_comment')}}</p>

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
    import CommentForm from "@/components/commentForm";
    import Comments from "@/components/comments";
    import Prism from '~/plugins/prism'
    export default {
        validate ({ params }) {
            return !!params.slug
        },
        head(){
            return {
                title: this.getLang(this.location, 'sphere') + ' — '
                    + this.getLang(this.location, 'blog') + ' — ' + this.post.title
            }
        },
        data(){
            return {
                recentPosts: '',
                categories: '',
                post: ''
            }
        },
        components: {CommentForm, AppAside, Comments},
        async asyncData({store, params}) {
            try {
                const {recentPosts} = await store.dispatch('home/posts');
                const {categories} = await store.dispatch('home/categories');
               const {post} = await store.dispatch('blog/post', params.slug);
                return {
                    recentPosts: recentPosts,
                    categories: categories,
                    post: post
                }
            }
            catch (error) {
                //console.log(error);
            }
        },
        methods: {
            answer(comment){
                this.$store.commit('auth/SET_ANSWER',
                    {author: comment.owner.name, date: comment.created_at, id: comment.id});
            },
            async ratePost(){
                try {
                   const {rate} = await this.$store.dispatch('auth/rate', {'post':this.post.id});
                    if (rate){ this.post.rate = rate}

                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        text: this.getLang(this.location, 'rateSucc')
                    });
                }catch (error) {
                    if(error.response.status === 403){
                        this.$notify({
                            type: 'error',
                            group: 'foo',
                            text: this.getLang(this.location, 'rated')
                        });
                    }
                }
            }
        },
        computed: {
            addedAnswer(){
                return this.$store.getters['auth/addedAnswer']
            }
        },
        watch: {
            addedAnswer(added) {
                if(!added.parent_id){
                    !this.post.comments.root ? this.$set(this.post.comments, 'root', [added]) : this.post.comments.root.push(added);
                }else{
                    if (this.post.comments.hasOwnProperty(added.parent_id)) {
                        this.post.comments[added.parent_id].push(added);
                    } else {
                        this.$set(this.post.comments, added.parent_id, [added]);
                    }
                    this.$scrollTo('#comment'+added.parent_id, 200, {offset: -200,});
                }
            }
        },
        mounted() {
            Prism.highlightAll();
        },
        beforeDestroy() {
            this.$store.commit('auth/SET_ANSWER', null);
            this.$store.commit('auth/SET_ADDED_ANSWER', null);
        }
    }
</script>

<style scoped>

</style>
