<template>
  <div class="projects">
    <ProjectsPrItem v-for="project in projects" :project="project"/>
  </div>
</template>

<script setup>

const props = defineProps({
  projects: Array,
});


</script>
