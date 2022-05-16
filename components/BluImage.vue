<template>
  <v-lazy-image
      :src="src"
      :src-placeholder="srcPlaceholder"
      alt="Image"
  ></v-lazy-image>
</template>


<script setup>
import VLazyImage from "v-lazy-image";

const props = defineProps({
  src: String,
  srcPlaceholder: String,
});

</script>

<style scoped lang="scss">
.v-lazy-image {
  filter: blur(10px);
  transition: filter 1.6s;
  will-change: filter;
}
.v-lazy-image-loaded {
  filter: blur(0);
}
</style>

<!--
.v-lazy-image {
filter: blur(10px);
transition: filter 0.7s;
}
.v-lazy-image-loaded {
filter: blur(0);
}-->
