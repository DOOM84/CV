<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Образование</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-education-create'})" class="btn btn-success mw-100">Добавить учебное заведение</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Учебное заведение</th>
        <th>Учебное заведение (англ.)</th>
        <th>Учебное заведение (укр.)</th>
        <th>Факультет/подразделение</th>
        <th>Факультет/подразделение (англ.)</th>
        <th>Факультет/подразделение (укр.)</th>
        <th>Детали (специальность и т.д.)(англ.)</th>
        <th>Детали (специальность и т.д.)(англ.)</th>
        <th>Детали (специальность и т.д.)(укр.)</th>
        <th>Год начала обучения</th>
        <th>Год окончания обучения</th>
        <th>Опубликовано</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(training, index) in trainings" :key="training.id">
        <td>{{index+1}}</td>
        <td>{{training.univer}}</td>
        <td>{{training.en_univer}}</td>
        <td>{{training.ua_univer}}</td>
        <td>{{training.faculty}}</td>
        <td>{{training.en_faculty}}</td>
        <td>{{training.ua_faculty}}</td>
        <td>{{training.details}}</td>
        <td>{{training.en_details}}</td>
        <td>{{training.ua_details}}</td>
        <td>{{training.start}}</td>
        <td>{{training.end}}</td>
        <td>{{training.status ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(training)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(training.id)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Образование'
            }
        },
        data() {
            return {
                trainings: ''

            }
        },
        async asyncData({store}) {
            try {
                const {trainings} = await store.dispatch('adminTraining/index');
                return {
                    trainings,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(training) {
                this.$router.push({name: 'admin-education-edit', params: { 'training': training} })
            },
            async handleDelete(id){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminTraining/delete', id);
                    this.trainings.splice(this.trainings.findIndex(item => item.id === id), 1);
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
