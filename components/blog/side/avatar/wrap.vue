<template>
  <div class="upload-avatar">
    <input ref="file" type="file" class="ava-upload" @change="onFileChange"/>
    <button class="btn-dark ava-upload__button" @click="onUploadFile"
            :disabled="!selectedFile">{{ $t('upload') }}
    </button>
  </div>
</template>

<script setup>
import getCookie from "@/helpers/getCookie";

import {ref} from 'vue';

const {$t, $showToast, $logOut} = useNuxtApp();


const props = defineProps({
  oldAva: String,
});

const selectedFile = ref(null);

const file = ref(null);

const emit = defineEmits(['ava'])

function onFileChange(e) {
  selectedFile.value = file.value.files[0];
}

async function onUploadFile() {
  if (!getCookie(document.cookie, 'token')) {
    $logOut();
    return
  }
  const formData = new FormData();
  formData.append("avatar", selectedFile.value);
  formData.append("oldAva", props.oldAva);
  $showToast($t('loading'), 'info', 2500);
  try {
    const data = await $fetch('/api/auth/avatar', {
      method: 'POST',
      body: formData,
    })
    file.value.value = '';
    selectedFile.value = null;
    emit('ava', data.path)

  } catch (e) {
    if (e.response.status === 422) {
      $showToast($t('error_file'), 'error');
    } else {
      $showToast($t('error_auth'), 'error');
      $logOut();
    }
  }
}

</script>


<style lang="scss" scoped>
.upload-avatar {
  text-align: center;
}

.ava-upload {
  width: 200px;
}

.ava-upload__button {
  display: inline-block;
  padding: 0.1rem 0.5rem;
  background: #14942b;
  margin-top: 0.5rem;

  &:disabled {
    background-color: #b3bcc4;
    color: black;
    cursor: no-drop;
  }
}


</style>