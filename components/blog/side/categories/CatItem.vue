<template>
  <li>
    <NuxtLink class="side-link" :to="'/blog/category/'+category.slug">
      {{ category[$gLoc() + '_name'] }}
    </NuxtLink>
  </li>
</template>

<script setup>

const props = defineProps({
  category: Object,
});

</script>
