<template>
  <div>

    <div id="modals"></div>
    <AdminModalWrap @closeDlg="toggleModal(false)" :showDlg="showDlg">
      <vue-load-image>
        <template v-slot:image>
          <img :src="project.images.original" alt="">
        </template>
        <template v-slot:preloader>

          <img src="/image-loader.gif"/>

        </template>
        <template v-slot:error>Image load fails</template>
      </vue-load-image>
    </AdminModalWrap>

    <div class="image-wrap">
      <BlurImage class="prjImg pointer" @click="toggleModal(true)"
          :src="project.images.thumbnail"
          :src-placeholder="project.images.thumbMin"
      />
      <a class="btn-light" :href="project.link" :target="project.link === '#' ? '' : '_blank'">
        <i class="fas fa-eye"></i> {{ project[$gLoc() + '_name'] }}
      </a>
    </div>


  </div>
</template>

<script setup>
import VueLoadImage from 'vue-load-image';

import {ref} from "vue";

const props = defineProps({
  project: Object,
});

const showDlg = ref(false)

function toggleModal(mode) {
  showDlg.value = mode
}


</script>

<style lang="scss" scoped>

</style>