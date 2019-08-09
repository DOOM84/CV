<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/education">Образование </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Добавить учебное заведение</li>
      </ol>
    </nav>
    <form @submit.prevent="onSubmit">
      <div class="form-group">
        <label>Учебное заведение</label>
        <input v-model="controls.univer" type="text" class="form-control" placeholder="Учебное заведение">
      </div>
      <div class="form-group">
        <label>Учебное заведение (англ.)</label>
        <input v-model="controls.en_univer" type="text" class="form-control" placeholder="Учебное заведение (англ.)">
      </div>
      <div class="form-group">
        <label>Учебное заведение (укр.)</label>
        <input v-model="controls.ua_univer" type="text" class="form-control" placeholder="Учебное заведение (укр.)">
      </div>
      <div class="form-group">
        <label>Факультет/подразделение</label>
        <input v-model="controls.faculty" type="text" class="form-control" placeholder="Факультет/подразделение">
      </div>
      <div class="form-group">
        <label>Факультет/подразделение (англ.)</label>
        <input v-model="controls.en_faculty" type="text" class="form-control" placeholder="Факультет/подразделение (англ.)">
      </div>
      <div class="form-group">
        <label>Факультет/подразделение (укр.)</label>
        <input v-model="controls.ua_faculty" type="text" class="form-control" placeholder="Факультет/подразделение (укр.)">
      </div>
      <div class="form-group">
        <label>Детали (специальность и т.д.)</label>
        <input v-model="controls.details" type="text" class="form-control" placeholder="Детали (специальность и т.д.)">
      </div>
      <div class="form-group">
        <label>Детали (специальность и т.д.) (англ.)</label>
        <input v-model="controls.en_details" type="text" class="form-control" placeholder="Детали (специальность и т.д.) (англ.)">
      </div>
      <div class="form-group">
        <label>Детали (специальность и т.д.) (укр.)</label>
        <input v-model="controls.ua_details" type="text" class="form-control" placeholder="Детали (специальность и т.д.) (укр.)">
      </div>
      <div class="form-group">
        <label>Год начала обучения</label>
        <input v-model="controls.start" type="text" class="form-control" placeholder="Год начала обучения">
      </div>
      <div class="form-group">
        <label>Год окончания обучения</label>
        <input v-model="controls.end" type="text" class="form-control" placeholder="Год окончания обучения">
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.status" class="custom-control-input" id="customSwitch1">
        <label class="custom-control-label" for="customSwitch1">Опубликовано</label>
      </div>

      <div class="form-group pb-3 text-center">
        <button type="submit" class="btn btn-success m-3 mw-100">Добавить</button>
      </div>

    </form>

  </div>
</template>

<script>
    export default {
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Добавить учебное заведение'
            }
        },
        data() {
            return {
                controls: {
                    univer : '',
                    en_univer : '',
                    ua_univer : '',
                    faculty : '',
                    en_faculty : '',
                    ua_faculty : '',
                    details : '',
                    en_details : '',
                    ua_details : '',
                    start : '',
                    end : '',
                    status : '',
                }
            }
        },
        methods: {
            async onSubmit() {
                        try {
                            const {success} = await this.$store.dispatch('adminTraining/create', this.controls);
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: success
                            });
                            this.$router.push('/admin/education')
                        } catch (e) {
                            console.log(e);
                        }
            },
        },
    }

</script>

<style scoped>

</style>
