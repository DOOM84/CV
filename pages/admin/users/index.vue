<template>
  <main class="withFooter">

    <AdminModalWrap @closeDlg="closeModal" mWidth="1000px" origWidth="100%" :showDlg="showDlg">
      <div class="form-group center">
        <img v-if="userToUpdate.photoURL" class="userImg"
             :src="userToUpdate.photoURL">
      </div>
      <div class="form-group">
        <label for="image">Аватар</label>
        <input class="" ref="file" type="file" id="image" @change="onFileChange"/>
      </div>
      <div class="form-group">
        <label for="login">Имя</label>
        <input type="text" v-model="userToUpdate.displayName" class="form-control " id="login">
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" v-model="userToUpdate.email" class="form-control " id="email">
      </div>
      <div class="form-group">
        <label for="password">Пароль</label>
        <input type="password" v-model="userToUpdate.password" class="form-control " id="password">
      </div>
      <div class="form-group">
        <label for="password_confirmation">Пароль еще раз</label>
        <input type="password" v-model="userToUpdate.passwordConfirmation" class="form-control "
               id="password_confirmation">
      </div>
      <div v-if="userToUpdate.customClaims" class="right">
        <label for="role">Администратор</label>
        <input type="checkbox" v-model="userToUpdate.customClaims.admin" id="role">
      </div>
      <div class="right">
        <label for="status">Заблокирован</label>
        <input type="checkbox" v-model="userToUpdate.disabled" id="status">
      </div>

      <button
          type="button"
          class="btn btn-dark"
          @click.prevent="storeItem">
        Сохранить
      </button>
    </AdminModalWrap>

    <div>
      <h2 class="mt-1">Пользователи</h2>
    </div>

    <div class="right">
      <button
          type="button"
          @click.prevent="addItem">
        Добавить
      </button>
    </div>

    <ClientOnly>
      <AdminDtable @endFilter="toFilter = false"
                   :data="data.users"
                   :toFilter="toFilter"
                   :filtering="filtering"
                   :toSearch="['displayName', 'email']">
        <template #thead>
          <table-head>
            <div class="flexCentered">
              <strong>Имя</strong>
              <i @click.self="filter('displayName', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('displayName', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Изображение</strong>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Email</strong>
              <i @click.self="filter('email', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('email', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Администратор</strong>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Заблокирован</strong>
            </div>
          </table-head>
          <table-head/>
        </template>

        <template #rows="{row}">
          <table-body>
            {{row.displayName}}
          </table-body>
          <table-body>
            <img width="80" :src="row.photoURL">
          </table-body>
          <table-body>
            {{row.email}}
          </table-body>
          <table-body>
            {{ row.customClaims['admin'] ? 'Да' : 'Нет' }}
          </table-body>
          <table-body>
            {{ row.disabled ? 'Да' : 'Нет' }}
          </table-body>
          <table-body>
            <button @click.prevent="updateItem(row)" class="button block btn-dark"><i class="fas fa-edit"></i></button>
            <button @click.prevent="removeItem(row)" class="button block btn-dark"><i class="fas fa-trash"></i></button>
          </table-body>
        </template>
      </AdminDtable>
    </ClientOnly>

  </main>
</template>

<script setup>
import {ref} from "vue";

const {$t, $showToast} = useNuxtApp();
import {useRouter} from 'vue-router';

const router = useRouter();

const {data, error} = await useAsyncData('users', () => $fetch('/api/admin/users'));

const userToUpdate = ref({customClaims: {admin: false}, disabled: false});
const showDlg = ref(false);
const mode = ref(null);
const file = ref(null);
const selectedFile = ref(null);

definePageMeta({
  layout: 'admin'
})

const filtering = ref([]);
const toFilter = ref(false);

function filter(fTerm, dir){
  filtering.value = [fTerm, dir]
  toFilter.value = true;
}


function onFileChange(e) {
  selectedFile.value = file.value.files[0];
}

function closeModal() {
  showDlg.value = false;
  mode.value = null;
  userToUpdate.value = {customClaims: {admin: false}, disabled: false};
  selectedFile.value = null;
}

function updateItem(user) {
  mode.value = 'edit';
  userToUpdate.value = {...user}
  showDlg.value = true;
}

function addItem() {
  mode.value = 'add';
  showDlg.value = true;
}

async function storeItem() {

  const formData = new FormData();
  formData.append('data', JSON.stringify(userToUpdate.value))
  if (selectedFile.value) {
    formData.append("file", selectedFile.value);
  }

  try {
    $showToast($t('loading'), 'info', 2000);
    if (mode.value === 'edit') {
      const {result} = await $fetch('/api/admin/users/edit', {
        method: 'PUT',
        body: formData,
      })
      const ind = data.value.users.findIndex(item => item.uid === result.uid);
      data.value.users[ind] = result;
    }

    if (mode.value === 'add') {
      const {result} = await $fetch('/api/admin/users/add', {
        method: 'POST',
        body: formData,
      })
      data.value.users.unshift(result);
    }

    filter(null, null);

    closeModal();

    $showToast('Информация успешно изменена', 'success', 2000);

  } catch (e) {

    if (e.response.status === 422) {

      $showToast(e.response._data.msg, 'error');

    } else if (e.response.status === 403) {

      $showToast('Доступ запрещен', 'error');

      await router.replace('/404')

    } else {

     $showToast($t('error_email_exists'), 'error', 2000);

    }

  }
}

async function removeItem(user) {

  if (confirm('Are you sure?')) {

    try {
      const formData = new FormData();

      formData.append('data', JSON.stringify({id: user.uid, /*image:user.photoURL*/}))

      $showToast($t('loading'), 'info', 2000);

      const {id} = await $fetch('/api/admin/users/remove', {
        method: 'DELETE',
        body: formData,
      })

      data.value.users.splice(data.value.users.findIndex(item => item.uid === id), 1);

      filter(null, null);

      $showToast('Информация успешно удалена', 'success', 2000);

    } catch (e) {

      if (e.response.status === 403) {

        $showToast('Доступ запрещен', 'error');

        await router.replace('/404')

      }
    }

  }
}
</script>


<style scoped lang="scss">

.userImg {
  margin: 1rem;
  width: 80px
}

</style>