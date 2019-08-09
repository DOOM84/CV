<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Места работы</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-works-create'})" class="btn btn-success mw-100">Добавить место работы</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Дата начала работы</th>
        <th>Дата начала работы (англ.)</th>
        <th>Дата начала работы (укр.)</th>
        <th>Дата окончания работы</th>
        <th>Дата окончания работы (англ.)</th>
        <th>Дата окончания работы (укр.)</th>
        <th>Должность</th>
        <th>Должность (англ.)</th>
        <th>Должность (укр.)</th>
        <th>Организация</th>
        <th>Организация (англ.)</th>
        <th>Организация (укр.)</th>
        <th>Детали</th>
        <th>Детали (англ.)</th>
        <th>Детали (укр.)</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(work, index) in works" :key="work.id">
        <td>{{index+1}}</td>
        <td>{{work.start}}</td>
        <td>{{work.en_start}}</td>
        <td>{{work.ua_start}}</td>
        <td>{{work.end}}</td>
        <td>{{work.en_end}}</td>
        <td>{{work.ua_end}}</td>
        <td>{{work.seat}}</td>
        <td>{{work.en_seat}}</td>
        <td>{{work.ua_seat}}</td>
        <td>{{work.company}}</td>
        <td>{{work.en_company}}</td>
        <td>{{work.ua_company}}</td>
        <td>{{work.description}}</td>
        <td>{{work.en_description}}</td>
        <td>{{work.ua_description}}</td>
        <td>{{work.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(work)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(work.id)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Места работы'
            }
        },
        data() {
            return {
                works: ''

            }
        },

        async asyncData({store}) {
            try {
                const {works} = await store.dispatch('adminWork/index');
                //console.log(posts);
                return {
                    works,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(work) {
                this.$router.push({name: 'admin-works-edit', params: { 'work': work} })
            },
            async handleDelete(id){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminWork/delete', id);
                    this.works.splice(this.works.findIndex(item => item.id === id), 1);
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
