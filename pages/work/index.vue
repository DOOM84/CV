<template>
  <main id="work" class="withFooter">
    <h1 class="lg-heading">
      {{ $t('my_projects.my') }}
      <span class="text-secondary">{{ $t('my_projects.projects') }}</span>
    </h1>
    <h2 class="sm-heading">
      {{ $t('projects_det') }}...
    </h2>
    <div v-if="pending" class="projects">
      <TheSkeleton v-for="i in 8"></TheSkeleton>
    </div>
    <ProjectsPrWrap v-else :projects="data.projects"/>

  </main>
</template>

<script setup>

const {data, error, pending} = await useLazyAsyncData('projects', () => $fetch('/api/projects'),
    {initialCache: false})

const {$t} = useNuxtApp();

const title = computed(() => $t('sphere') + ' — ' + $t('projects'))

useHead({
  title: title
})

</script>
