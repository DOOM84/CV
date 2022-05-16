<template>
  <main class="withFooter">

      <AdminModalWrap @closeDlg="closeModal" mWidth="1000px" origWidth="100%" :showDlg="showDlg">
      <div class="form-group">
        <label for="ru_name">Должность (рус)</label>
        <input type="text" v-model.trim="trainingToUpdate.ru_name" class="form-control " id="ru_name">
      </div>
      <div class="form-group">
        <label for="ua_name">Должность (укр)</label>
        <input type="text" v-model.trim="trainingToUpdate.ua_name" class="form-control " id="ua_name">
      </div>
      <div class="form-group">
        <label for="en_name">Должность (англ)</label>
        <input type="text" v-model.trim="trainingToUpdate.en_name" class="form-control " id="en_name">
      </div>
      <div class="form-group">
        <label for="ru_description">Описание (рус)</label>
        <input type="text" v-model.trim="trainingToUpdate.ru_description" class="form-control " id="ru_description">
      </div>
      <div class="form-group">
        <label for="ua_description">Описание (укр)</label>
        <input type="text" v-model.trim="trainingToUpdate.ua_description" class="form-control " id="ua_description">
      </div>
      <div class="form-group">
        <label for="en_description">Описание (англ)</label>
        <input type="text" v-model.trim="trainingToUpdate.en_description" class="form-control " id="en_description">
      </div>
      <div class="form-group">
        <label for="year">Годы</label>
        <input type="text" v-model.trim="trainingToUpdate.year" class="form-control " id="year">
      </div>
      <div class="form-group">
        <label for="begin">Год начала</label>
        <input type="text" v-model.trim="trainingToUpdate.begin" class="form-control " id="begin">
      </div>
      <div class="right">
        <label for="status">Опубликовано</label>
        <input type="checkbox" v-model="trainingToUpdate.status" id="status">
      </div>

      <button
          type="button"
          class="btn btn-dark"
          @click.prevent="storeItem">
        Сохранить
      </button>
    </AdminModalWrap>

    <div>
      <h2 class="mt-1">Информация</h2>
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
                   :data="facts"
                   :toFilter="toFilter"
                   :filtering="filtering"
                   :toSearch="['ru_name', 'ua_name', 'en_name']">
        <template #thead>
          <table-head>
            <div class="flexCentered">
              <strong>Должность (рус)</strong>
              <i @click.self="filter('ru_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ru_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Должность (укр)</strong>
              <i @click.self="filter('ua_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ua_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Должность (англ)</strong>
              <i @click.self="filter('en_name', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('en_name', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Год</strong>
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
            {{row.ru_name}}
          </table-body>
          <table-body>
            {{row.ua_name}}
          </table-body>
          <table-body>
            {{row.en_name}}
          </table-body>
          <table-body>
            {{ row.year }}
          </table-body>
          <table-body>
            {{ row.status ? 'Да': 'Нет' }}
          </table-body>
          <table-body>
            <button @click.prevent="updateItem(row)" class="button block btn-dark"><i class="fas fa-edit"></i></button>
            <button @click.prevent="removeItem(row.id)" class="button block btn-dark"><i class="fas fa-trash"></i></button>
          </table-body>
        </template>
      </AdminDtable>
    </ClientOnly>
  </main>
</template>

<script setup>
import {ref} from 'vue';
import {useRouter} from 'vue-router';
const {$t, $showToast} = useNuxtApp();
const router = useRouter();

const {data: facts, error} = await useAsyncData('about', () => $fetch('/api/admin/about'));

const trainingToUpdate = ref({status: false});
const showDlg = ref(false);
const mode = ref(null);

definePageMeta({
  layout: 'admin'
})

const filtering = ref([]);
const toFilter = ref(false);

function filter(fTerm, dir){
  filtering.value = [fTerm, dir]
  toFilter.value = true;
}

function closeModal() {
  showDlg.value = false;
  mode.value = null;
  trainingToUpdate.value = {status: false}
}

function updateItem(fact) {
  mode.value = 'edit';
  trainingToUpdate.value = {...fact}
  showDlg.value = true;
}

function addItem() {
  mode.value = 'add';
  showDlg.value = true;
}

async function storeItem() {

  const formData = new FormData();
  formData.append('data', JSON.stringify(trainingToUpdate.value))
  try {
    $showToast($t('loading'), 'info', 2000);
    if (mode.value === 'edit') {
      const result = await $fetch('/api/admin/about/edit', {
        method: 'PUT',
        body: formData,
      })
      const ind = facts.value.findIndex(item => item.id === result.id);
      facts.value[ind] = result;
    }

    if (mode.value === 'add') {
      const result = await $fetch('/api/admin/about/add', {
        method: 'POST',
        body: formData,
      })
      facts.value.unshift(result);
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

async function removeItem(factId) {
  if (confirm('Are you sure?')) {
    try {

      const formData = new FormData();
      formData.append('id', factId);

      $showToast($t('loading'), 'info', 2000);

      const {id} = await $fetch('/api/admin/about/remove', {
        method: 'DELETE',
        body: formData,
      })

      facts.value.splice(facts.value.findIndex(item => item.id === id), 1);

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