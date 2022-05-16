<template>
  <main id="home" class="withoutFooter">
    <h1 class="lg-heading">
      {{ $t('full_name.name') }} <span class="text-secondary">{{ $t('full_name.surname') }}</span>
    </h1>
    <h2 class="sm-heading">
      {{$t('sphere')}}
    </h2>
  </main>
</template>

<script setup>
const {$t} = useNuxtApp();

const title = computed(() => $t('sphere') + ' — ' + $t('welcome'))

useHead({
  title: title
})


</script>
