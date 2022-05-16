<template>
  <div>
      <BlogPostsPWrap @nextP="nextPage" :showIcon="showIcon" :posts="searchResult"/>

  </div>
</template>


<script setup>

definePageMeta({
  layout: 'blog'
})

const unBlockBtn = useUnBlockBtn();

import {useRoute} from 'vue-router';
import {ref, watch, onMounted} from 'vue';

const route = useRoute();
const {$t} = useNuxtApp();
const showIcon = ref(false);
const queryTerm = useTerm();
const searchResult = useResult();
const resultsCount = useResultsCount();
const blogInfo = useBlogInfo();


const bInfo = computed(() => $t('found') + ': ' +  resultsCount.value + ', ' +  $t('on_query') + ': ' +  queryTerm.value);


onMounted(()=>{
  blogInfo.value = bInfo;
})

const title = computed(() => $t('sphere') + ' — ' + $t('search') + ' — ' + blogInfo.value)

useHead({
  title: title
})

watch(route, () => {
  queryTerm.value = '';
  searchResult.value = [];
  resultsCount.value = 0;
})

async function nextPage() {

  if (unBlockBtn.value) {
    return
  }

  showIcon.value = true;
  unBlockBtn.value = true;

  let lastItemIndex = searchResult.value[searchResult.value.length - 1].createdAt;

  const { data } = await useFetch('/api/search',
      {params: {lastTimeStamp: lastItemIndex, term: queryTerm.value}})


  if (!data.value.posts.length) {
    unBlockBtn.value = true;
    showIcon.value = false;
    return
  }

  searchResult.value.push(...data.value.posts);

  showIcon.value = false;
  unBlockBtn.value = false;
}

</script>
