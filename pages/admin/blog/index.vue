<template>
  <main class="withFooter">

    <AdminModalWrap @closeDlg="closeModal" mWidth="1000px" origWidth="100%" :showDlg="showDlg">
      <div class="form-group">
        <img v-if="postToUpdate.images" class="form-img" :src="postToUpdate.images.thumbnail">
        <label for="image">Изображение</label>
        <input class="mr-1" ref="file" type="file" id="image" @change="onFileChange"/>
      </div>
      <div class="form-group">
        <label for="ua_name">Название (укр)</label>
        <input type="text" v-model.trim="postToUpdate.ua_title" class="form-control " id="ua_name">
      </div>
      <div class="form-group">
        <label for="ru_name">Название (рус)</label>
        <input type="text" v-model.trim="postToUpdate.ru_title" class="form-control " id="ru_name">
      </div>
      <div class="form-group">
        <label for="en_name">Название (англ)</label>
        <input type="text" v-model.trim="postToUpdate.en_title" class="form-control " id="en_name">
      </div>
      <div class="form-group">
        <label for="ua_details">Описание (укр)</label>
        <input type="text" v-model.trim="postToUpdate.ua_subtitle" class="form-control " id="ua_details">
      </div>
      <div class="form-group">
        <label for="ru_details">Описание (рус)</label>
        <input type="text" v-model.trim="postToUpdate.ru_subtitle" class="form-control " id="ru_details">
      </div>
      <div class="form-group">
        <label for="en_details">Описание (англ)</label>
        <input type="text" v-model.trim="postToUpdate.en_subtitle" class="form-control " id="en_details">
      </div>
      <div class="form-group">
        <label>Категории</label>
        <select v-model="postToUpdate.categories" multiple class="w100" id="categories">
          <option v-for="(category, i) in data.categories" :key="i" :value="category.slug">{{ category.ru_name }}
          </option>
        </select>
      </div>
      <ClientOnly>
        <div class="form-group">
          <label>Теги</label>
          <tag-input v-model=postToUpdate.tags>
          </tag-input>
        </div>
      </ClientOnly>

      <AdminTheEditor @updatedContent="updatedContent" :content="postToUpdate.body"></AdminTheEditor>

      <div class="form-group">
        <label for="author">Автор</label>
        <input type="text" v-model="postToUpdate.author" class="form-control " id="author">
      </div>
      <div class="form-group">
        <label for="source">Источник</label>
        <input type="text" v-model="postToUpdate.source" class="form-control " id="source">
      </div>
      <div class="right">
        <label for="status">Опубликовано</label>
        <input type="checkbox" v-model="postToUpdate.status" id="status">
      </div>

      <button
          type="button"
          class="btn btn-dark"
          @click.prevent="storeItem">
        Сохранить
      </button>
    </AdminModalWrap>

    <div>
      <h2 class="mt-1">Блог</h2>
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
                   :data="data.posts"
                   :toFilter="toFilter"
                   :filtering="filtering"
                   :toSearch="['ru_title', 'ua_title', 'en_title']">
        <template #thead>
          <table-head>
            <div class="flexCentered">
              <strong>Изображение</strong>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (рус)</strong>
              <i @click.self="filter('ru_title', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ru_title', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (укр)</strong>
              <i @click.self="filter('ua_title', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('ua_title', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Название (англ)</strong>
              <i @click.self="filter('en_title', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('en_title', 'desc')" class="fa fa-caret-down pointer"></i>
            </div>
          </table-head>
          <table-head>
            <div class="flexCentered">
              <strong>Автор</strong>
              <i @click.self="filter('author', 'asc')" class="fa ml-1 fa-caret-up pointer"></i>
              <i @click.self="filter('author', 'desc')" class="fa fa-caret-down pointer"></i>
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
            {{row.ru_title}}
          </table-body>
          <table-body>
            {{row.ua_title}}
          </table-body>
          <table-body>
            {{row.en_title}}
          </table-body>
          <table-body>
            {{ row.author }}
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
import slugify from "slugify";
import {ref} from "vue";

const {$t, $showToast} = useNuxtApp();
import {useRouter} from 'vue-router';

definePageMeta({
  layout: 'admin'
})

const filtering = ref([]);
const toFilter = ref(false);

function filter(fTerm, dir){
  filtering.value = [fTerm, dir]
  toFilter.value = true;
}

const router = useRouter();

useNuxtApp().vueApp.config.compilerOptions.isCustomElement = tag => tag.startsWith('tag-') || tag.startsWith('QuillEditor')

const {data, error} = await useAsyncData('adminPosts', () => $fetch('/api/admin/blog'))

const content = ref('');
const postToUpdate = ref({categories: [], tags: [], body: '', status: false, author: 'admin'});
const showDlg = ref(false);
const mode = ref(null);
const file = ref(null);
const selectedFile = ref(null);

function bodyUpd(content) {
  postToUpdate.value.body = content;
}

function closeModal() {
  showDlg.value = false;
  mode.value = null;
  postToUpdate.value = {categories: [], tags: [], body: '', author: 'admin'};
  selectedFile.value = null;
}

function updateItem(post) {
  mode.value = 'edit';
  postToUpdate.value = {...post}
  showDlg.value = true;
}

function addItem() {
  mode.value = 'add';
  showDlg.value = true;
}

function onFileChange(e) {
  selectedFile.value = file.value.files[0];
}

function updatedContent(cont){
  postToUpdate.value.body = cont;
}

async function storeItem() {

  if (postToUpdate.value.tags) {
    postToUpdate.value.tags = postToUpdate.value.tags.map((tag) => ({
      name: tag,
      slug: slugify(tag, {strict: true}).toLowerCase()
    }));
  }

  const formData = new FormData();
  formData.append('data', JSON.stringify(postToUpdate.value))
  if (selectedFile.value) {
    formData.append("file", selectedFile.value);
  }

  try {
    $showToast($t('loading'), 'info', 2000);
    if (mode.value === 'edit') {
      const result = await $fetch('/api/admin/blog/edit', {
        method: 'PUT',
        body: formData,
      })
      const ind = data.value.posts.findIndex(item => item.slug === result.slug);

      data.value.posts[ind] = result;
    }

    if (mode.value === 'add') {
      const result = await $fetch('/api/admin/blog/add', {
        method: 'POST',
        body: formData,
      })
      data.value.posts.unshift(result);
    }
    filter(null, null);

    closeModal();

    $showToast('Информация успешно изменена', 'success', 2000);

  } catch (e) {
    if (postToUpdate.value.tags) {
      postToUpdate.value.tags = postToUpdate.value.tags.map((tag) => tag.name)
    }

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


async function removeItem(post) {

  if (confirm('Are you sure?')) {

    try {

      const formData = new FormData();

      formData.append('data', JSON.stringify({slug: post.slug, images: post.images}))

      $showToast($t('loading'), 'info', 2000);

      const {slug} = await $fetch('/api/admin/blog/remove', {
        method: 'DELETE',
        body: formData,
      })

      data.value.posts.splice(data.value.posts.findIndex(item => item.slug === slug), 1);

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

.htmlText {
  height: 800px;
  resize: none;
}

.htmlTextBtn {
  color: black;
  padding: 0;
  margin: 0
}

</style>



