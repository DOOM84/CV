<template>
  <div>
    <client-only>
      <div v-if="pending || error" class="center">
        <i class="fas fa-circle-notch fa-spin fa-4x"></i>
      </div>
      <BlogPostsPWrap v-else @nextP="nextPage" :showIcon="showIcon" :posts="data.posts"/>
    </client-only>
  </div>
</template>

<script setup>

definePageMeta({
  layout: 'blog'
})

import {computed, ref, onMounted} from 'vue';

import {useNextPage} from "@/composables/useNextPage";

const route = useRoute();

const router = useRouter();

const {$t, $gLoc} = useNuxtApp();

const blogInfo = useBlogInfo();

const unBlockBtn = useUnBlockBtn();

const {data, error, pending} = await useLazyAsyncData('category', () => $fetch('/api/category',
    {params: {slug: route.params.id}}), {initialCache: false})

if (process.server && error?.value) {
  throwError(error.value)
}

watch(error, (newError) => {
  if(!!newError){
    router.replace('/404')
  }
})

const showIcon = ref(false);

const catName = computed(() => {

  return data.value ? data.value.category[$gLoc() + '_name'] : '';
})

const bInfo = computed(() => $t('category') + ': ' + catName.value);

watch(data, () => {
  blogInfo.value = bInfo;
})

onMounted(()=>{
  if(blogInfo.value === $t('category') + ':'){blogInfo.value = bInfo}
})

const title = computed(() => $t('sphere') + ' — ' + $t('blog')  + ' — ' + $t('category') + ' — ' +
    (data.value ? data.value.category[$gLoc() + '_name'] : ''))

useHead({
  title: title
})

async function nextPage() {
  await useNextPage(data.value.posts, unBlockBtn, showIcon, route.params.id, '/api/category');
}


</script>
