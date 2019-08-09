<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Пользователи</li>
    </ol>
  </nav>
  <div class="pb-3 text-center ">
  <button @click="$router.push({name: 'admin-users-create'})" class="btn btn-success w-25">Добавить пользователя</button>
  </div>
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>#</th>
        <th>Имя</th>
        <th>email</th>
        <th>Аватар</th>
        <th>Статус</th>
        <th>Администратор</th>
        <th colspan="2"></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(user, index) in users" :key="user.id">
        <td>{{index+1}}</td>
        <td>{{user.name}}</td>
        <td>{{user.email}}</td>
        <td><img :src="user.avatar" width="71px" alt=""></td>
        <td>{{user.status ? 'Активен' : 'Заблокирован'}}</td>
        <td>{{user.is_admin ? 'Да' : 'Нет'}}</td>
        <td colspan="2" style="display: inline-flex">
          <button @click.prevent="handleEdit(user)" class="btn btn-info mr-2"><span class="fa fa-edit"></span></button>
          <button @click.prevent="handleDelete(user.id)" class="btn btn-warning"><span class="fa fa-trash-o"></span></button>
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
                title: 'Панель управления — Пользователи'
            }
        },
        data() {
            return {
                users: ''

            }
        },

        async asyncData({store}) {
            try {
                const {users} = await store.dispatch('adminUser/index');
                return {
                    users,
                }
            } catch (error) {
                /*if(error.response.status === 401){
                    return $nuxt.$router.replace('/login');
                }*/
            }
        },
        methods: {
            handleEdit(user) {
                this.$router.push({name: 'admin-users-edit', params: { 'user': user} })
            },
            async handleDelete(id){
                if (confirm('Are You Sure?')){
                    const {success} = await this.$store.dispatch('adminUser/delete', id);
                    this.users.splice(this.users.findIndex(item => item.id === id), 1);
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
