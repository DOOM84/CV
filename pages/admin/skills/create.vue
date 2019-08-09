<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/skills">Технологии </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Добавить технологию</li>
      </ol>
    </nav>
    <form @submit.prevent="onSubmit">

      <div class="form-group">
        <label>Название</label>
        <input v-model="controls.name" type="text" class="form-control" placeholder="Название">
      </div>

      <div class="form-group">
        <label>Название (англ.)</label>
        <input v-model="controls.en_name" type="text" class="form-control" placeholder="Название (англ.)">
      </div>

      <div class="form-group">
        <label>Уровень использования</label>
        <input v-model="controls.rate" type="text" class="form-control" placeholder="Уровень использования">
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
                title: 'Панель управления — Добавить технологию'
            }
        },
        data() {
            return {
                controls: {
                    name: '',
                    en_name: '',
                    rate: '',
                    status: '',
                },
            }
        },
        methods: {
            async onSubmit() {
                        try {
                            const {success} = await this.$store.dispatch('adminSkill/create', this.controls);
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: success
                            });
                            this.$router.push('/admin/skills')
                        } catch (e) {
                            console.log(e);
                        }
            },
        },
    }

</script>

<style scoped>

</style>
