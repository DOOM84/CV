<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Категории</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-categories-create'})" class="btn btn-success w-25">Добавить категорию</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Название</th>
        <th>Название (англ)</th>
        <th>Название (укр)</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(category, index) in categories" :key="category.id">
        <td>{{index+1}}</td>
        <td>{{category.name}}</td>
        <td>{{category.en_name}}</td>
        <td>{{category.ua_name}}</td>
        <td>{{category.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(category)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(category.slug)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Категории'
            }
        },
        data() {
            return {
                categories: ''

            }
        },

        async asyncData({store}) {
            try {
                const {categories} = await store.dispatch('adminCategory/index');
                //console.log(posts);
                return {
                    categories,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(category) {
                this.$router.push({name: 'admin-categories-edit', params: { 'category': category} })
            },
            async handleDelete(slug){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminCategory/delete', slug);
                    this.categories.splice(this.categories.findIndex(item => item.slug === slug), 1);
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
