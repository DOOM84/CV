<template>
  <main class="withFooter">

    <AdminModalWrap @closeDlg="closeModal" mWidth="1000px" origWidth="100%" :showDlg="showDlg">
      <div class="form-group">
        <img v-if="projectToUpdate.images" class="form-img" :src="projectToUpdate.images.thumbnail">
        <label for="image">Изображение</label>
        <input class="mr-1" ref="file" type="file" id="image" @change="onFileChange"/>
      </div>
      <div class="form-group">
        <label for="ua_name">Название (укр)</label>
        <input type="text" v-model="projectToUpdate.ua_name" class="form-control " id="ua_name">
      </div>
      <div class="form-group">
        <label for="ru_name">Название (рус)</label>
        <input type="text" v-model="projectToUpdate.ru_name" class="form-control " id="ru_name">
      </div>
      <div class="form-group">
        <label for="en_name">Название (англ)</label>
        <input type="text" v-model="projectToUpdate.en_name" class="form-control " id="en_name">
      </div>
      <div class="form-group">
        <label for="ua_details">Описание (укр)</label>
        <input type="text" v-model="projectToUpdate.ua_details" class="form-control " id="ua_details">
      </div>
      <div class="form-group">
        <label for="ru_details">Описание (рус)</label>
        <input type="text" v-model="projectToUpdate.ru_details" class="form-control " id="ru_details">
      </div>
      <div class="form-group">
        <label for="en_details">Описание (англ)</label>
        <input type="text" v-model="projectToUpdate.en_details" class="form-control " id="en_details">
      </div>
      <div class="form-group">
        <label for="link">Ссылка</label>
        <input type="text" v-model="projectToUpdate.link" class="form-control " id="link">
      </div>
      <div class="right">
        <label for="status">Опубликовано</label>
        <input type="checkbox" v-model="projectToUpdate.status" id="status">
      </div>

      <button
          type="button"
          class="btn btn-dark"
          @click.prevent="storeItem">
        Сохранить
      </button>
    </AdminModalWrap>

    <div>
      <h2 class="mt-1">Проекты</h2>
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
                   :data="projects"
                   :toFilter="toFilter"
                   :filtering="filtering"
                   :toSearch="['ru_name', 'ua_name', 'en_name']">
        <template #thead>
          <table-head>
            <div class="flexCentered">
              <strong>Изображение</strong>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (рус)</strong>
              <i @click.self="filter('ru_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ru_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (укр)</strong>
              <i @click.self="filter('ua_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ua_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (англ)</strong>
              <i @click.self="filter('en_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('en_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Ссылка</strong>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Опубликовано</strong>
            </div>
          </table-head>
          <table-head/>
        </template>
        <template #rows="{row}">
          <table-body>
            <img width="100" :src="row.images.thumbnail">
          </table-body>
          <table-body>
            {{row.ru_name}}
          </table-body>
          <table-body>
            {{row.ua_name}}
          </table-body>
          <table-body>
            {{row.en_name}}
          </table-body>
          <table-body>
            {{ row.link }}
          </table-body>
          <table-body>
            {{ row.status ? 'Да': 'Нет' }}
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

const {data: projects, error} = await useAsyncData('projects', () => $fetch('/api/admin/projects'))

const projectToUpdate = ref({status: false});
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
  projectToUpdate.value = {status: false};
  selectedFile.value = null;
}

function updateItem(project) {
  mode.value = 'edit';
  projectToUpdate.value = {...project}
  showDlg.value = true;
}

function addItem() {
  mode.value = 'add';
  showDlg.value = true;
}

async function storeItem() {

  if (mode.value === 'add' && !selectedFile.value) {
    $showToast('Отсутствует изображение', 'error', 2000);
    return
  }

  const formData = new FormData();
  formData.append('data', JSON.stringify(projectToUpdate.value))
  if (selectedFile.value) {
    formData.append("file", selectedFile.value);
  }

  try {
    $showToast($t('loading'), 'info', 2000);
    if (mode.value === 'edit') {
      const result = await $fetch('/api/admin/projects/edit', {
        method: 'PUT',
        body: formData,
      })
      const ind = projects.value.findIndex(item => item.id === result.id);
      projects.value[ind] = result;
    }

    if (mode.value === 'add') {
      const result = await $fetch('/api/admin/projects/add', {
        method: 'POST',
        body: formData,
      })
      projects.value.unshift(result);
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

      $showToast('Вы не авторизованы', 'error', 2000);

    }

  }
}

async function removeItem(project) {

  if (confirm('Are you sure?')) {

    try {

      const formData = new FormData();

      formData.append('data', JSON.stringify({id: project.id, images: project.images}))

      $showToast($t('loading'), 'info', 2000);

      const {id} = await $fetch('/api/admin/projects/remove', {
        method: 'DELETE',
        body: formData,
      })

      projects.value.splice(projects.value.findIndex(item => item.id === id), 1);

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