<template>
  <div>
    <h2 class="sm-heading">
      {{ $tc('comments', commentsCount) }}
    </h2>
    <div v-for="comment in comments" class="comments-container">
      <BlogSingleCommentsCItem @delCom="delCom" @quoting="quoting" :comment="comment"/>
    </div>

    <h2 class="sm-heading mt-1">
      {{ $t('leave_com') }}
    </h2>
    <transition name="quote">
      <div v-if="quote" class="quote">
        <p>
          <em>{{ quote.user.name }} ({{ $showDate(quote.date) }}):</em>
        </p>
        <p>
          "{{ quote.body }}"
        </p>
        <div class="quoteClose">
          <i @click="quote=null" class="fas fa-times pointer"></i>
        </div>
      </div>
    </transition>

    <textarea v-model.trim="commentBody" class="input" id="commentForm" cols="30" rows="10"
              :placeholder="$t('comment')"></textarea>

    <div class="right">
      <button @click="comment" class="button">{{ $t('send') }}</button>
    </div>
  </div>

</template>

<script setup>
import {ref} from 'vue';
const {$t, $tc, $showToast, $logOut, $scrollTo} = useNuxtApp();
import {useRouter} from 'vue-router';

const router = useRouter();

const props = defineProps({
  comments: Object,
  commentsCount: Number,
  slug: String,
});

const emit = defineEmits(['comDeleted', 'comAdded'])

const commentBody = ref('');
const quote = ref(null);

async function delCom(id) {

  const formData = new FormData();
  formData.append('slug', props.slug);
  formData.append('id', id);

  try {
    $showToast($t('loading'), 'info', 2000);
    const {toDel} = await $fetch('/api/admin/comdel', {
      method: 'DELETE',
      body: formData,
    })
    emit('comDeleted', toDel)
  } catch (e) {

    $logOut();

    if (e.response.status === 401) {
      $showToast($t('error_auth'), 'error');
    }

    if (e.response.status === 403) {
      $showToast($t('error_access'), 'error');
      await router.replace('/404')
    }

  }
}

function quoting(comment) {
  quote.value = {
    body: comment.body.substr(0, 200) + '...',
    date: comment.createdAt,
    user: {name: comment.user.name}
  }

  $scrollTo('#commentForm', 800, {offset: -100})
}

async function comment() {

  if (!commentBody.value || commentBody.value.indexOf('\n\n\n') > 0) {
    $showToast($t('error_text'), 'error');
    return
  }
  if (commentBody.value.length > 8000) {
    $showToast($t('error_length'), 'error');
    return
  }

  const formData = new FormData();
  formData.append('slug', props.slug);
  formData.append('comment', commentBody.value);
  if (quote.value) {
    formData.append('quote', JSON.stringify(quote.value))
  }
  try {
    $showToast($t('loading'), 'info', 2000);
    const {newComment} = await $fetch('/api/auth/comment', {
      method: 'POST',
      body: formData,
    })
    emit('comAdded', newComment)
    commentBody.value = '';
    quote.value = null;
  } catch (e) {

    if (e.response.status === 422) {

      $showToast($t(e.response.data.msg), 'error');

    }

    if (e.response.status === 401) {
      $showToast($t('error_auth'), 'error');
      $logOut();
    }

  }
}

</script>

<style lang="scss" scoped>
.comments-container {
  width: 100%;
  margin-top: 3rem;
}

.quote {
  text-align: left;
  background: #000;
  padding: 1rem;
  margin-bottom: 1rem;
  position: relative;
}

.quoteClose {
  position: absolute;
  top: 0;
  right: 5px;
}

.quote-enter-from {
  opacity: 0;
  transform: translateY(15px);
}

.quote-enter-active {
  transition: all 1.5s;
}

.quote-leave-active {
  transition: all 1.5s;
}

.quote-enter {
  opacity: 0;
}

.quote-leave-to {
  opacity: 0;
}

</style>