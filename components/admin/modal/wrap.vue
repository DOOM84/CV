<template>
  <MyModal
      v-model="showDlg"
      :close="closeModal"
  >
    <div class="modal" :style="{ maxWidth: mWidth, width: origWidth }" style="padding: 30px" >

      <i @click="closeModal"  class="closeBtn fas fa-times pointer"></i>

        <slot></slot>

    </div>
  </MyModal>
</template>

<script setup>
const props = defineProps({
  showDlg: Boolean,
  mWidth: String,
  origWidth: {type: String, default: 'auto'},
});

const emit = defineEmits(['closeDlg'])

function closeModal() {
  emit('closeDlg');
}

</script>

<style lang="scss">

.closeBtn{
  position: absolute; top:10px; right: 10px
}

.modal {
  position: relative;
  color: black;
  //max-width: 400px;
  padding: 30px;
  box-sizing: border-box;
  background-color: #fff;
  /*font-size: 20px;*/
  text-align: left;
}

.vue-universal-modal-leave-from,
.vue-universal-modal-enter-to {
  opacity: 1;
}

.vue-universal-modal-enter-from,
.vue-universal-modal-leave-to {
  opacity: 0;
}

.vue-universal-modal {
  -webkit-overflow-scrolling: touch;
  -ms-scroll-chaining: none;
  overscroll-behavior: contain;
  position: fixed;
  overflow-y: auto;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.8);
  text-align: left;
  z-index: 2000;
}

.vue-universal-modal:not(.vue-universal-modal-latest) {
  background: none;
}

.vue-universal-modal-content {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -ms-flex-direction: column;
  flex-direction: column;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  width: 100%;
  min-height: 100%;
}

</style>