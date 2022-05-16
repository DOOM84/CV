<template>
  <div>
    <div v-if="pending || error"  class="center">
      <i class="fas fa-circle-notch fa-spin fa-4x"></i>
    </div>

      <div v-else class="blog">
        <div class="post-container">

          <div class="image-wrap">
            <BlurImage
                :src="data.post.images.original"
                :src-placeholder="data.post.images.thumbMin"
            />
            <div class="post-date">{{ $postDate(data.post.createdAt) }}</div>
          </div>

          <div class="info-container">
            <span>{{ data.post.author }}</span>
            <div class="post-info">
              <div v-if="data.post.likes">{{ data.post.likes }}</div>
              <div><i @click="rate" class="pointer" :class="likes"></i>
              </div>
            </div>
            <div class="post-info">
              <div v-if="comCount">{{ comCount }}</div>
              <div><i class="fas fa-comment"></i>
              </div>
            </div>
          </div>
          <div class="tags-container">
            <div v-for="tag in data.postTags" class="tags">
              <NuxtLink class="btn-dark tags" :to="'/blog/tag/'+tag.slug">
                {{ tag.name }}
              </NuxtLink>

            </div>
          </div>
          <h2 class="center">{{ data.post[$gLoc() + '_title'] }}</h2>
          <div class="post-text" v-html="data.post.body"></div>

        </div>
        <BlogSingleCommentsCWrap  @comDeleted="comDeleted" @comAdded="comAdded"
                                 :slug="data.post.slug"
                                 :commentsCount="comCount"
                                 :comments="postComments"
        />

      </div>
  </div>
</template>

<script setup>

definePageMeta({
  layout: 'blog'
})

import {onMounted, ref} from 'vue';

const {$t, $gLoc, $showToast, $logOut} = useNuxtApp();

const route = useRoute();
const router = useRouter();

const commentsToLoad = useLoadComments();

const postComments = ref([]);

const {data, error, pending} = await useLazyAsyncData('post', () => $fetch('/api/post',
    {params: {slug: route.params.id}, headers: useRequestHeaders(["cookie"])}), {initialCache: false})

if (process.server) {
  if(error?.value){
    throwError(error.value)
  }else{
    commentsToLoad.value = true;
  }
}

watch(error, (newError) => {
  if(!!newError){
    router.replace('/404')
  }
})

watch(route, () => {
  commentsToLoad.value = false;
})

watch(data, async (newData) => {

  if(newData?.post){
    await loadComments();
  }
})

onMounted(async ()=>{

  if(commentsToLoad.value){
    await loadComments();
  }
})

async function loadComments(){
  const {comments} = await $fetch('/api/comments',
      {params: {slug: route.params.id}})
  postComments.value = comments;
}

const title = computed(() => $t('sphere') + ' — ' + $t('blog') + ' — ' +

    (data.value ?  data.value.post[$gLoc() + '_title'] : ''))

useHead({
  title: title
})

//onMounted(()=>{})

const likes = computed(() => !data.value.post.isLiked ? 'fas fa-thumbs-up isLiked' :
    'fas fa-thumbs-down isNotLiked')

const comCount = computed(() => postComments.value.length || 0);

function comAdded(comment) {
  postComments.value.push(comment);
  $showToast($t('comment_added'), 'success');
}

function comDeleted(toDel) {
  postComments.value.splice(postComments.value.findIndex(item => item.id === toDel), 1);
  $showToast($t('comment_removed'), 'success');
}

async function rate() {

  const formData = new FormData();
  formData.append('slug', route.params.id);
  try {
    $showToast($t('loading'), 'info', 2000);
    const {likes, isLiked} = await $fetch('/api/auth/rate', {
      method: 'POST',
      body: formData,
    })
    data.value.post.likes = likes;
    data.value.post.isLiked = isLiked;
    $showToast($t('voted'), 'success');
  } catch (e) {
    if (e.response.status === 401) {
      $showToast($t('error_auth'), 'error');
      $logOut();
    }

  }
}

</script>

<style lang="scss" scoped>
.isLiked {
  color: #49e849;
}

.isNotLiked {
  color: #f31039;
}

.post-info {
  display: flex;
  gap: 5px
}

.image-wrap {
  position: relative;
  text-align: center;
  max-width: 770px;
  margin: 0 auto;


  img{
    border-radius: 5%;
  }

  &:hover {
    opacity: 0.5;
    border-color: #eece1a;
    transition: all 0.5s ease-out;
  }
}

/*.v-lazy-image {
  width: 100%;
}*/

.v-lazy-image {
  max-width: 100%;
  width: 770px;
  max-height: 400px;
  border-radius: 5%;
  border: #eece1a 3px solid;
}

</style>