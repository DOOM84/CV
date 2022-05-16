<template>

    <div class="job" :class="cls">
      <h3>{{fact.year}}</h3>
      <h6>{{fact[$gLoc()+'_name']}}</h6>
      <p>
        {{fact[$gLoc()+'_description']}}
      </p>
    </div>
</template>

<script setup>
const props = defineProps({
  fact: Object,
  cls: String,
});
</script>
