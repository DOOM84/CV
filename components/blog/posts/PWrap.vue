<template>
  <div class="blog">
    <BlogPostsPItem v-for="post in posts" :post="post"/>
    <button v-if="posts && posts.length >= 10" :disabled="unBlockBtn" class="button w100" @click="nextP">
      <i v-if="showIcon" class="fas fa-sync fa-spin"></i>
      <span v-else>{{ $t('load_more') }}</span>
    </button>
  </div>
</template>

<script setup>
const {$t} = useNuxtApp();

const props = defineProps({
  posts: Array,
  showIcon: Boolean,
});

const unBlockBtn = useUnBlockBtn();

const emit = defineEmits(['nextP'])

function nextP(){
  emit('nextP')
}

</script>
