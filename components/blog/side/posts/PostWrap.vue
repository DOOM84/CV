<template>
  <div class="post-menu__container">
    <h2 class="left title">{{ $t('recent_post') }}</h2>
    <BlogSidePostsPostItem v-for="recentPost in recentPosts" :recentPost="recentPost"/>
  </div>
</template>

<script setup>

const props = defineProps({
  recentPosts: Array,
});

const {$t} = useNuxtApp();

</script>
