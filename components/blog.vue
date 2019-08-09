<template>
    <div class="container py-lg-5">
        <div class="row blog_w3l_top">
            <div class="col-lg-8 blog_w3l_right">
                <h4 class="heading text-left mb-5"><nuxt-link to="/blog">{{getLang(location, 'blog')}}</nuxt-link></h4>
                <nuxt-link :to="posts[0].path"><img :src="posts[0].image" alt="news image" class="img-fluid"></nuxt-link>
                <div class="blog_w3l-5">
                    <h6>{{posts[0].title}}</h6>
                    <p>{{posts[0].subtitle}}</p>
                    <nuxt-link :to="posts[0].path" class="btn btn-primary mt-lg-4 mt-3 agile-link-bnr1" role="button">
                      <span class="fa fa-arrow-right mr-2"></span>{{getLang(location, 'read_more')}}</nuxt-link>
                </div>
            </div>
            <div class="col-lg-4 blog_w3l_left">
                <div v-for="(post, index) in posts" :class="'blog_w3l_left' + doMath(index)">
                    <div class="blog_w3l-2">
                        <h5>{{post.date}}</h5>
                        <h3 class="mt-2"><nuxt-link :to="post.path">{{post.title}}</nuxt-link></h3>
                        <p class="mt-3">{{post.subtitle}}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['posts'],
        data(){
            return {
            }
        },
        methods: {
            doMath(index) {
                return index+1
            }
        }
    }
</script>

<style scoped>

</style>
