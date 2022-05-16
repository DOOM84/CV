<template>
  <div>
    <TheHeader/>
    <main id="blog" class="withFooter">

      <h1 class="lg-heading">
        {{ $t('my') }}
        <span class="text-secondary">{{ $t('blog') }}</span>
      </h1>
        <h2 class="sm-heading">
          {{ blogInfo }}
        </h2>

      <div class="my-blog">
        <slot />
        <BlogSideWrap />
      </div>
    </main>
    <LazyTheFooter />
  </div>
</template>

<script setup>

import {computed, watch} from "vue";

const {$t} = useNuxtApp();

const route = useRoute();

const unBlockBtn = useUnBlockBtn();

const blogInfo = useBlogInfo();

const bInfo = computed(() => route.name === 'blog-category-id' ? $t('category')+ ':'
        : route.name === 'blog-tag-id' ? $t('tag') + ':' : $t('blog_info')); //

blogInfo.value = bInfo;

watch(route, () => {

  unBlockBtn.value = false;

  if(route.name === 'blog' || route.name === 'blog-post-id'){blogInfo.value = bInfo;}

})

</script>