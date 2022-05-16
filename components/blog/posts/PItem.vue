<template>

  <NuxtLink :to="'/blog/post/'+post.slug" class="nav-link">
    <div class="post-container">
      <div class="image-wrap">
        <BlurImage
            :src="post.images.original"
            :src-placeholder="post.images.thumbMin"
        />
        <div class="post-date">{{ date }}</div>
      </div>
      <div class="info-container">
        <span>{{ post.author }}</span>
        <span>{{ post.likes }} <i class="fas fa-thumbs-up"></i></span>
        <span>{{ post.comments }} <i class="fas fa-comment"></i></span>
      </div>
      <h2 class="center">{{ post[$gLoc() + '_title'] }}</h2>
      <p class="center">
        {{ post[$gLoc() + '_subtitle'] }}
      </p>
    </div>
  </NuxtLink>

</template>

<script setup>

import {computed} from "vue";

const {$postDate} = useNuxtApp();

const props = defineProps({
  post: Object,
});

const date = computed(() => $postDate(props.post.createdAt));

</script>

<style lang="scss" scoped>

.image-wrap {
  position: relative;
  text-align: center;
  max-width: 770px;
  margin: 0 auto;

  img{
    border-radius: 5%;
  }

  &:hover {
    opacity: 0.5;
    border-color: #eece1a;
    transition: all 0.5s ease-out;
  }
}

/*.v-lazy-image {
  width: 100%;
}*/

.v-lazy-image {
  max-width: 100%;
  width: 770px;
  max-height: 400px;
  border-radius: 5%;
  border: #eece1a 3px solid;
}

</style>