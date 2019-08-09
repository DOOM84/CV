<template>
    <aside class="col-lg-4 right-blog-con text-right">
        <div class="right-blog-info text-left">
            <div class="form-group has-search">
                <span class="fa fa-search form-control-feedback"></span>
                <input v-model.trim="search" @input="searchPost" type="text" class="form-control" :placeholder="getLang(location, 'search')">
              <transition name="fade">
                <ul v-if="search" class="results searchList">
                  <li class="p-3 searchItem" v-for="result in results" :key="result.id">
                    <nuxt-link style="color: #333" :to="result.path">
                    <img class="searchImg" :src="result.image" alt="">
                    <div class="searchTitle"> {{result.title}} <p class="text-right">{{result.date}}</p>
                    </div>
                    </nuxt-link>
                  </li>
                </ul>
              </transition>

            </div>
            <div class="tech-btm">
                <h4>{{getLang(location, 'categories')}}</h4>
                <ul class="list-group single">
                    <li v-for="category in categories" class="list-group-item d-flex justify-content-between align-items-center">
                        <nuxt-link style="color: #777" :to="'/blog/category/' + category.slug">
                          {{category[toLang('name')]}}
                        </nuxt-link>
                        <span class="badge badge-primary badge-pill">{{category.catposts}}</span>
                    </li>
                </ul>
            </div>
            <div class="tech-btm">
                <h4>{{getLang(location, 'recent_entries')}}</h4>
                <div v-for="post in posts" class="blog-grids row mb-3">
                    <div class="col-md-5 blog-grid-left">
                        <nuxt-link :to="post.path">
                            <img :src="post.image" class="img-fluid rounded" alt="">
                        </nuxt-link>
                    </div>
                    <div class="col-md-7 blog-grid-right">
                        <h5>
                            <nuxt-link :to="post.path">{{post.title}} </nuxt-link>
                        </h5>
                        <div class="sub-meta">
                            <span class="fa fa-clock-o pr-2"> {{post.date}}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="single-gd tech-btm">
                <h4>{{getLang(location, 'recent_post')}}</h4>
                <div class="blog-grids">
                    <div class="blog-grid-left">
                        <nuxt-link :to="posts[0].path">
                            <img :src="posts[0].image" class="img-fluid rounded" alt="">
                        </nuxt-link>
                    </div>
                    <div class="blog-grid-right">

                        <h5>
                            <nuxt-link :to="posts[0].path">{{posts[0].title}}</nuxt-link>
                        </h5>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>

    </aside>
</template>

<script>
    export default {
        props: ['posts', 'categories'],
        data(){
            return {
                search: '',
                results: '',
            }
        },
        methods: {
            async searchPost(){
                if (!this.search){return false}
                try {
                    const {results} = await this.$store.dispatch('blog/search', this.search);
                    this.results = results;
                } catch (error) {
                }
            }
        }
    }
</script>

<style lang="scss" scoped>
    .has-search .form-control {
        padding-left: 2.375rem;
    }
    .has-search .form-control-feedback {
        position: absolute;
        z-index: 2;
        display: block;
        width: 2.375rem;
        height: 2.375rem;
        line-height: 2.375rem;
        text-align: center;
        pointer-events: none;
        color: #aaa;
    }
    .results {
      width: 92%;
      position: absolute;
      z-index: 1000;
      background-color: #F5F5F5
    }
  .searchImg{
    display: inline-block;
    vertical-align:
      top; width: 30%;
  }
  .searchList{
    max-height: 600px;
    overflow-y: auto
  }
  .searchItem{
    border-bottom: 1px solid lightgrey;
  }
  .searchTitle{
    display: inline-block;
    padding-left: 10px;
    width: 62%
  }
</style>
