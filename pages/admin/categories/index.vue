<template>
  <main class="withFooter">

    <AdminModalWrap @closeDlg="closeModal" mWidth="1000px" origWidth="100%" :showDlg="showDlg">
      <div class="form-group">
        <label for="ru_name">Название (рус)</label>
        <input type="text" v-model.trim="categoryToUpdate.ru_name" class="form-control " id="ru_name">
      </div>
      <div class="form-group">
        <label for="ua_name">Название (укр)</label>
        <input type="text" v-model.trim="categoryToUpdate.ua_name" class="form-control " id="ua_name">
      </div>
      <div class="form-group">
        <label for="en_name">Название (англ)</label>
        <input type="text" v-model.trim="categoryToUpdate.en_name" class="form-control " id="en_name">
      </div>

      <div class="right">
        <label for="status">Опубликовано</label>
        <input type="checkbox" v-model="categoryToUpdate.status" id="status">
      </div>

      <button
          type="button"
          class="btn btn-dark"
          @click.prevent="storeItem">
        Сохранить
      </button>
    </AdminModalWrap>

    <div>
      <h2 class="mt-1">Категории</h2>
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
                   :data="categories"
                   :toFilter="toFilter"
                   :filtering="filtering"
                   :toSearch="['ru_name', 'ua_name', 'en_name']">
        <template #thead>
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
            {{ row.status ? 'Да': 'Нет' }}
          </table-body>
          <table-body>
            <button @click.prevent="updateItem(row)" class="button block btn-dark"><i class="fas fa-edit"></i></button>
            <button @click.prevent="removeItem(row.slug)" class="button block btn-dark"><i class="fas fa-trash"></i></button>
          </table-body>
        </template>
      </AdminDtable>
    </ClientOnly>
  </main>
</template>

<script setup>
const {data: categories, error} = await useAsyncData('adminCategories', () => $fetch('/api/admin/categories'))
import {ref} from "vue";
const {$t, $showToast} = useNuxtApp();
import {useRouter} from 'vue-router';
const router = useRouter();

const categoryToUpdate = ref({status: false})
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
  categoryToUpdate.value = {status: false}
}

function updateItem(category) {
  mode.value = 'edit';
  categoryToUpdate.value = {...category}
  showDlg.value = true;
}

function addItem() {
  mode.value = 'add';
  showDlg.value = true;
  categoryToUpdate.value.status = false;
}

async function storeItem() {

  const formData = new FormData();
  formData.append('data', JSON.stringify(categoryToUpdate.value))
  try {
    $showToast($t('loading'), 'info', 2000);
    if (mode.value === 'edit') {
      const result = await $fetch('/api/admin/categories/edit', {
        method: 'PUT',
        body: formData,
      })
      const ind = categories.value.findIndex(item => item.slug === result.slug);
      categories.value[ind] = result;
    }

    if (mode.value === 'add') {
      const result = await $fetch('/api/admin/categories/add', {
        method: 'POST',
        body: formData,
      })
      categories.value.unshift(result);
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

async function removeItem(catSlug) {
  if (confirm('Are you sure?')) {
    try {

      const formData = new FormData();
      formData.append('slug', catSlug);

      $showToast($t('loading'), 'info', 2000);

      const {slug} = await $fetch('/api/admin/categories/remove', {
        method: 'DELETE',
        body: formData,
      })

      categories.value.splice(categories.value.findIndex(item => item.slug === slug), 1);

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