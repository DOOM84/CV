<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Проекты</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-projects-create'})" class="btn btn-success w-25">Добавить проект</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Название</th>
        <th>Название (англ)</th>
        <th>Название (укр)</th>
        <th>Описание</th>
        <th>Описание (англ)</th>
        <th>Описание (укр)</th>
        <th>Технологии</th>
        <th>Изображение</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(project, index) in projects" :key="project.id">
        <td>{{index+1}}</td>
        <td>{{project.name}}</td>
        <td>{{project.en_name}}</td>
        <td>{{project.ua_name}}</td>
        <td v-html="project.details"></td>
        <td v-html="project.en_details"></td>
        <td v-html="project.ua_details"></td>
        <td>
          <ul>
            <li v-for="skill in project.skills" :key="skill.id">{{skill.name}}</li>
          </ul>
        </td>
        <td><img :src="project.image" width="100px" alt=""></td>
        <td class="text-center">{{project.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(project)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(project.id)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Проекты'
            }
        },
        data() {
            return {
                projects: ''

            }
        },

        async asyncData({store}) {
            try {
                const {projects} = await store.dispatch('adminProject/index');
                return {
                    projects,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(project) {
                this.$router.push({name: 'admin-projects-edit', params: { 'project': project} })
            },
            async handleDelete(id){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminProject/delete', id);
                    this.projects.splice(this.projects.findIndex(item => item.id === id), 1);
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
