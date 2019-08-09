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
        <li class="breadcrumb-item active" aria-current="page">Изменить технологию</li>
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
      <button type="submit" class="btn btn-success m-3 mw-100">Изменить</button>
      </div>

    </form>
  </div>
</template>

<script>
    export default {
        validate ({ params }) {
            return !!params.skill
        },
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Изменить технологию'
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
                            await this.$store.dispatch('adminSkill/update', {data: this.controls,
                                slug: this.$route.params.skill.slug});
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: 'Технология успешно изменена'
                            });
                            this.$router.push('/admin/skills')
                        } catch (e) {
                            console.log(e);
                        }
            },
        },
        mounted() {
                this.controls.name = this.$route.params.skill.name;
                this.controls.en_name = this.$route.params.skill.en_name;
                this.controls.rate = this.$route.params.skill.rate;
                this.controls.status = this.$route.params.skill.status;
        }
    }

</script>

<style scoped>

</style>
