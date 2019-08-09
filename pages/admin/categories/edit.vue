<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/categories">Категории </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Изменить категорию</li>
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
        <label>Название (укр.)</label>
        <input v-model="controls.ua_name" type="text" class="form-control" placeholder="Название (укр.)">
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.status" class="custom-control-input" id="customSwitch1">
        <label class="custom-control-label" for="customSwitch1">Опубликовано</label>
      </div>

      <div class="form-group pb-3 text-center">
      <button type="submit" class="btn btn-success m-3 w-25">Изменить</button>
      </div>

    </form>
  </div>
</template>

<script>
    export default {
        validate ({ params }) {
            return !!params.category
        },
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Изменить категорию'
            }
        },

        data() {
            return {
                controls: {
                    name: '',
                    en_name: '',
                    ua_name: '',
                    status: '',
                },
            }
        },
        methods: {
            async onSubmit() {
                        try {
                            await this.$store.dispatch('adminCategory/update', {data: this.controls,
                                slug: this.$route.params.category.slug});
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: 'Категория успешно изменена'
                            });
                            this.$router.push('/admin/categories')
                        } catch (e) {
                            console.log(e);
                        }
            },
        },
        mounted() {
                this.controls.name = this.$route.params.category.name;
                this.controls.en_name = this.$route.params.category.en_name;
                this.controls.ua_name = this.$route.params.category.ua_name;
                this.controls.status = this.$route.params.category.status;
        }
    }

</script>

<style scoped>

</style>
