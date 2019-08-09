<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/works">Места работы </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Изменить место работы</li>
      </ol>
    </nav>
    <form @submit.prevent="onSubmit">
      <div class="form-group">
        <label>Дата начала работы</label>
        <input v-model="controls.start" type="text" class="form-control" placeholder="Дата начала работы">
      </div>
      <div class="form-group">
        <label>Дата начала работы (англ.)</label>
        <input v-model="controls.en_start" type="text" class="form-control" placeholder="Дата начала работы (англ.)">
      </div>
      <div class="form-group">
        <label>Дата начала работы (укр.)</label>
        <input v-model="controls.ua_start" type="text" class="form-control" placeholder="Дата начала работы (укр.)">
      </div>
      <div class="form-group">
        <label>Дата окончания работы</label>
        <input v-model="controls.end" type="text" class="form-control" placeholder="Дата окончания работы">
      </div>
      <div class="form-group">
        <label>Дата окончания работы (англ.)</label>
        <input v-model="controls.en_end" type="text" class="form-control" placeholder="Дата окончания работы (англ.)">
      </div>
      <div class="form-group">
        <label>Дата окончания работы (укр.)</label>
        <input v-model="controls.ua_end" type="text" class="form-control" placeholder="Дата окончания работы (укр.)">
      </div>
      <div class="form-group">
        <label>Должность</label>
        <input v-model="controls.seat" type="text" class="form-control" placeholder="Должность">
      </div>
      <div class="form-group">
        <label>Должность (англ.)</label>
        <input v-model="controls.en_seat" type="text" class="form-control" placeholder="Должность (англ.)">
      </div>
      <div class="form-group">
        <label>Должность (укр.)</label>
        <input v-model="controls.ua_seat" type="text" class="form-control" placeholder="Должность (укр.)">
      </div>
      <div class="form-group">
        <label>Организация</label>
        <input v-model="controls.company" type="text" class="form-control" placeholder="Организация">
      </div>
      <div class="form-group">
        <label>Организация (англ.)</label>
        <input v-model="controls.en_company" type="text" class="form-control" placeholder="Организация (англ.)">
      </div>
      <div class="form-group">
        <label>Организация (укр.)</label>
        <input v-model="controls.ua_company" type="text" class="form-control" placeholder="Организация (укр.)">
      </div>
      <div class="form-group">
        <label>Детали</label>
        <input v-model="controls.description" type="text" class="form-control" placeholder="Детали">
      </div>
      <div class="form-group">
        <label>Детали (англ.)</label>
        <input v-model="controls.en_description" type="text" class="form-control" placeholder="Детали (англ.)">
      </div>
      <div class="form-group">
        <label>Детали (укр.)</label>
        <input v-model="controls.ua_description" type="text" class="form-control" placeholder="Детали (укр.)">
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
            return !!params.work
        },
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Изменить место работы'
            }
        },

        data() {
            return {
                controls: {
                    start : '',
                    en_start : '',
                    ua_start : '',
                    end : '',
                    en_end : '',
                    ua_end : '',
                    seat : '',
                    en_seat : '',
                    ua_seat : '',
                    company : '',
                    en_company : '',
                    ua_company : '',
                    description : '',
                    en_description : '',
                    ua_description : '',
                    status : '',
                }
            }
        },
        methods: {
            async onSubmit() {
                        try {
                            await this.$store.dispatch('adminWork/update', {data: this.controls,
                                id: this.$route.params.work.id});
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: 'Место работы успешно изменено'
                            });
                            this.$router.push('/admin/works')
                        } catch (e) {
                            console.log(e);
                        }
            },
        },
        mounted() {
                this.controls.start = this.$route.params.work.start,
                this.controls.en_start = this.$route.params.work.en_start,
                this.controls.ua_start = this.$route.params.work.ua_start,
                this.controls.end = this.$route.params.work.end,
                this.controls.en_end = this.$route.params.work.en_end,
                this.controls.ua_end = this.$route.params.work.ua_end,
                this.controls.seat = this.$route.params.work.seat,
                this.controls.en_seat = this.$route.params.work.en_seat,
                this.controls.ua_seat = this.$route.params.work.ua_seat,
                this.controls.company = this.$route.params.work.company,
                this.controls.en_company = this.$route.params.work.en_company,
                this.controls.ua_company = this.$route.params.work.ua_company,
                this.controls.description = this.$route.params.work.description,
                this.controls.en_description = this.$route.params.work.en_description,
                this.controls.ua_description = this.$route.params.work.ua_description,
                this.controls.status = this.$route.params.work.status
        }
    }

</script>

<style scoped>

</style>
