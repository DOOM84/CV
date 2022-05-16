<template>
  <main className="withFooter center">
    <h2>{{ $t('notFound') }}</h2>
    <h3>{{ $t('notFoundMsg') }}</h3>
    <NuxtLink class="white" to="/">{{ $t('home') }}</NuxtLink>
  </main>
</template>

<script setup>
const {$t} = useNuxtApp();

definePageMeta({
  layout: 'error'
})

const title = computed(() => $t('sphere') + ' — ' + $t('notFound'))

useHead({
  title: title
})

</script>


<style scoped lang="scss">

.withFooter {
  height: 53vh;
  align-items: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

</style>
