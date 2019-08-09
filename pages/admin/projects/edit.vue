<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/projects">Проекты </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Изменить проект</li>
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

      <div class="form-group">
        <label>Описание</label>
        <input v-model="controls.details" type="text" class="form-control" placeholder="Описание">
      </div>

      <div class="form-group">
        <label>Описание (англ.)</label>
        <input v-model="controls.en_details" type="text" class="form-control" placeholder="Описание (англ.)">
      </div>

      <div class="form-group">
        <label>Описание (укр.)</label>
        <input v-model="controls.ua_details" type="text" class="form-control" placeholder="Описание (укр.)">
      </div>

      <div class="form-group pt-3">

        <multiselect
          v-model="controls.skills"
          :options="skills"
          :multiple="true"
          :close-on-select="false"
          :clear-on-select="false"
          :hide-selected="false"
          :preserve-search="false"
          placeholder="Выберите технологию"
          label="name"
          track-by="name"
          :preselect-first="true"
          id="id"

        ></multiselect>
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.status" class="custom-control-input" id="customSwitch1">
        <label class="custom-control-label" for="customSwitch1">Опубликовано</label>
      </div>

    <div class="form-group pt-3">
      <label>Изображение</label>
      <input class="w-100" type="file" id="file" ref="file" @change="handleFileUpload"/>
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
            return !!params.project
        },
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Изменить проект'
            }
        },

        data() {
            return {
                image: '',
                controls: {
                    name: '',
                    en_name: '',
                    ua_name: '',
                    details: '',
                    en_details: '',
                    ua_details: '',
                    skills: [],
                    status: '',
                },
                skills: '',
            }
        },
        async asyncData({store}) {
            try {
                const {skills} = await store.dispatch('adminProject/edit');
                //console.log(techs);
                return {
                    skills
                }
            } catch (error) {
                /* if (error.response.status === 401) {
                     return $nuxt.$router.replace('/login');
                 }*/
            }
        },
        methods: {
            async onSubmit() {
                const formData = new FormData();
                for (let elem in this.controls) {
                    if(elem === 'skills'){formData.append(elem, JSON.stringify(this.filterItem(this.controls.skills)))}
                   else{ formData.append(elem, JSON.stringify(this.controls[elem]));}
                }
                formData.append('image', this.image);
                formData.append('_method', 'PATCH');
                        try {
                            await this.$store.dispatch('adminProject/update', {data: formData,
                                id: this.$route.params.project.id});
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: 'Проект успешно изменен'
                            });
                            this.$router.push('/admin/projects')
                        } catch (e) {
                            console.log(e);
                        }
            },
            filterItem(objArr){
                let result = [];
                for (let i = 0; i < objArr.length; i++) {
                    if (typeof objArr[i] === 'object' && objArr[i].constructor === Object) {
                        result.push(objArr[i].id);
                    }
                }
                return result.length > 0 ? result : objArr;
            },
            handleFileUpload() {
                this.image = this.$refs.file.files[0];
            },
        },
        mounted() {
                this.controls.name = this.$route.params.project.name;
                this.controls.en_name = this.$route.params.project.en_name;
                this.controls.ua_name = this.$route.params.project.ua_name;
                this.controls.details = this.$route.params.project.details;
                this.controls.en_details = this.$route.params.project.en_details;
                this.controls.ua_details = this.$route.params.project.ua_details;
                this.controls.skills = this.$route.params.project.skills;
                this.controls.status = this.$route.params.project.status;
        }
    }

</script>

<style scoped>

</style>
