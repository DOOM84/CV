<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Посты (блог)</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-posts-create'})" class="btn btn-success w-25">Добавить пост</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Название</th>
        <th>Название (англ)</th>
        <th>Описание</th>
        <th>Описание (англ)</th>
        <th>Категории</th>
        <th>Изображение</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(post, index) in posts" :key="post.id">
        <td>{{index+1}}</td>
        <td>{{post.title}}</td>
        <td>{{post.en_title}}</td>
        <td>{{post.subtitle}}</td>
        <td>{{post.en_subtitle}}</td>
        <td>
          <ul>
            <li v-for="category in post.categories" :key="category.id">{{category.name}}</li>
          </ul>
        </td>
        <td><img :src="post.image" width="100px" alt=""></td>
        <td class="text-center">{{post.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(post)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(post.slug)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
        </td>
      </tr>

      </tbody>
    </table>
  </div>
</div>
</template>

<script>
    export default {
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Посты (блог)'
            }
        },
        data() {
            return {
                posts: ''

            }
        },

        async asyncData({store}) {
            try {
                const {posts} = await store.dispatch('adminPost/index');
                //console.log(posts);
                return {
                    posts,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(post) {
                this.$router.push({name: 'admin-posts-edit', params: { 'post': post} })
            },
            async handleDelete(post){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminPost/delete', post);
                    this.posts.splice(this.posts.findIndex(item => item.slug === post), 1);
                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        text: success
                    });
                }
            },
        }
    }

</script>

<style scoped>

</style>
