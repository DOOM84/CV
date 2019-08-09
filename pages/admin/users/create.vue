<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/users">Пользователи </nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Добавить пользователя</li>
      </ol>
    </nav>
    <form @submit.prevent="onSubmit">

      <div class="form-group">
        <label>Имя</label>
        <input v-model="controls.name" type="text" class="form-control" placeholder="Имя">
      </div>

      <div class="form-group">
        <label>email</label>
        <input v-model="controls.email" type="email" class="form-control" placeholder="E-mail">
      </div>

      <div class="form-group">
        <label>Пароль</label>
        <input class="form-control" type="password" v-model="controls.password" name="Password" placeholder="Пароль" required="">
      </div>

      <div class="form-group">
        <label>Подтвердите пароль</label>
        <input class="form-control" type="password" v-model="controls.password_confirmation" name="Password_confirmation" placeholder="Подтвердите пароль"  required="">
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.status" class="custom-control-input" id="customSwitch1">
        <label class="custom-control-label" for="customSwitch1">Статус</label>
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.is_admin" class="custom-control-input" id="customSwitch2">
        <label class="custom-control-label" for="customSwitch2">Администратор</label>
      </div>

    <div class="form-group pt-3">
      <label>Аватар</label>
      <input class="w-100" type="file" id="file" ref="file" @change="handleFileUpload"/>
    </div>
      <div class="form-group pb-3 text-center">
      <button type="submit" class="btn btn-success m-3 w-25">Добавить</button>
      </div>

    </form>

  </div>
</template>

<script>
    export default {
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Добавить пользователя'
            }
        },
        data() {
            return {
                image: '',
                controls: {
                    name: '',
                    email: '',
                    password: '',
                    password_confirmation: '',
                    status: false,
                    is_admin: false
                },
            }
        },
        methods: {
            async onSubmit() {
                const formData = new FormData();
                for (let elem in this.controls) {
                  formData.append(elem, JSON.stringify(this.controls[elem]));
                }
                formData.append('image', this.image);
                        try {
                            const {success} = await this.$store.dispatch('adminUser/create', formData);
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: success
                            });
                            this.$router.push('/admin/users')
                        } catch (e) {
                            console.log(e);
                        }
            },
            handleFileUpload() {
                this.image = this.$refs.file.files[0];
            },
        },
    }

</script>

<style scoped>

</style>
