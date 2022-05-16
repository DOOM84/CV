<template>
  <footer id="main-footer">
    © {{ new Date().getFullYear() }} | {{ $t('sphere') }}
  </footer>
</template>

<script setup>
const {$t} = useNuxtApp();
</script>
