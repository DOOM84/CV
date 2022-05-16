<template>
  <div>
    <client-only>
      <div v-if="pending" class="center">
        <i class="fas fa-circle-notch fa-spin fa-4x"></i>
      </div>
      <BlogPostsPWrap v-else @nextP="nextPage" :showIcon="showIcon" :posts="data.posts"/>
    </client-only>
  </div>
</template>

<script setup>

import {ref} from 'vue';

const {$t} = useNuxtApp();

const {data, error, pending} = await useLazyAsyncData('blog', () => $fetch('/api/blog'),
    {initialCache: false})

const unBlockBtn = useUnBlockBtn();

const showIcon = ref(false);

definePageMeta({
  layout: 'blog'
})

const title = computed(() => $t('sphere') + ' — ' + $t('blog'))

useHead({
  title: title
})

async function nextPage() {

  if (unBlockBtn.value) {
    return
  }

  let itemsLength = data.value.posts.length;
  let lastItemIndex = data.value.posts[itemsLength - 1].createdAt;


  unBlockBtn.value = true;
  showIcon.value = true;

  const {posts} = await $fetch('/api/blog', {
    params: {
      lastTimeStamp: lastItemIndex,
      itemsLength: itemsLength
    }
  });

  data.value.posts = posts;
  if (data.value.posts.length === itemsLength) {
    unBlockBtn.value = true;
    showIcon.value = false;
  } else {
    unBlockBtn.value = false;
    showIcon.value = false;
  }
}

</script>
