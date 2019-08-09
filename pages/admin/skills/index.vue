<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Технологии</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-skills-create'})" class="btn btn-success mw-100">Добавить технологию</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Название</th>
        <th>Название (англ)</th>
        <th>Уровень использования</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(skill, index) in skills" :key="skill.id">
        <td>{{index+1}}</td>
        <td>{{skill.name}}</td>
        <td>{{skill.en_name}}</td>
        <td>{{skill.rate}}%</td>
        <td>{{skill.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(skill)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(skill.slug)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Технологии'
            }
        },
        data() {
            return {
                skills: ''

            }
        },

        async asyncData({store}) {
            try {
                const {skills} = await store.dispatch('adminSkill/index');
                //console.log(posts);
                return {
                    skills,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(skill) {
                this.$router.push({name: 'admin-skills-edit', params: { 'skill': skill} })
            },
            async handleDelete(slug){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminSkill/delete', slug);
                    this.skills.splice(this.skills.findIndex(item => item.slug === slug), 1);
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
