<template>

  <div>
    <TheHeader/>
    <slot/>
    <LazyTheFooter v-if="showFooter"/>
  </div>

</template>

<script setup>

import {onMounted, computed, watch} from 'vue';

import {useRoute} from 'vue-router';

const route = useRoute();

const showBgImg = computed(() => {
  return route.path === '/' ? 'bg-img' : '';
});

const showFooter = computed(() => {
  return route.path !== '/';
});

watch(route, () => {
  document.body.id = showBgImg.value;
})

onMounted(() => {
  document.body.id = showBgImg.value;
})

</script>