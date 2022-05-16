<template>
  <div class="bmenu">
    <form @submit.prevent="search">
      <input class="input" type="text" v-model.trim="term" :placeholder="$t('search')+'...'">
    </form>
    <div class="auth">
      <NuxtLink v-if="isLoggedIn === false" class="side-link title center"
                :to="{ name: 'auth', params: { prevRoute: $route.path }}">
        {{ $t('login') }} / {{ $t('register') }}
      </NuxtLink>
      <span v-else-if="!user">
           <i class="fas fa-sync fa-spin"></i>
        </span>
      <template v-else>
        <h3> {{ user?.name }} </h3>
        <img class="avatar" @click="avaUpload = !avaUpload" :src="avatar" alt="">
        <BlogSideAvatarWrap :oldAva="user.avatar" @ava="setAva" v-if="avaUpload"/>
        <button class="btn btn-dark" @click="logOut">{{ $t('logOut') }}</button>
      </template>
    </div>

    <client-only>
      <template v-if="pending">
        <div  class="center">
          <i class="fas fa-circle-notch fa-spin fa-2x"></i>
        </div>
      </template>
      <template v-else>
        <BlogSidePostsPostWrap :recentPosts="data.recentPosts"/>

        <BlogSideCategoriesCatWrap :categories="data.categories"/>

        <BlogSideTagsTagWrap :tags="data.tags"/>
      </template>
    </client-only>



  </div>
</template>

<script setup>
import {computed, ref} from 'vue';
import {useRoute, useRouter} from 'vue-router';
const {$logOut, $t} = useNuxtApp();
//const isLoggedIn = useState('isLoggedIn');
const isLoggedIn = useLoggedIn();
const user = useUserInfo();

const route = useRoute();
const router = useRouter();
const unBlockBtn = useUnBlockBtn();

const {data, error, pending} = await useLazyAsyncData('sidebar', () => $fetch('/api/sidebar'))

const term = ref('');
const avaUpload = ref(false);
const queryTerm = useTerm();
const searchResult = useResult();
const resultsCount = useResultsCount();


/*const avatar = computed(() => user.value.avatar ? '/img/avatars/' + user.value.avatar
    : '/img/avatars/no_avatar.png');*/

const avatar = computed(() => user.value.avatar.substring(user.value.avatar.indexOf('/img')));

function setAva(path) {
  user.value.avatar = path;
  avaUpload.value = false;
}

function logOut() {
  $logOut();
}

async function search() {


  let strippedTerm = term.value.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>{}\[\]\\\/]/gi, '');
  strippedTerm = strippedTerm.replace(/<\/?("[^"]*"|'[^']*'|[^>])*(>|$)/g, "");

  if (queryTerm.value && (queryTerm.value === strippedTerm) || strippedTerm.length < 3) {
    return
  }

  queryTerm.value = strippedTerm;

  const {posts, results} = await $fetch('/api/search',
      {params: {term: strippedTerm, sdb: 'no'}});

  searchResult.value = posts;
  resultsCount.value = +results;

  if(route.path !== '/blog/search'){

    await router.push('/blog/search');

  }else{
    unBlockBtn.value = false;
  }
}

</script>

<style lang="scss" scoped>
.auth {
  display: flex;
  flex-direction: column;
  margin-top: 1rem;
  align-items: center;
}

.avatar {
  border-radius: 50%;
  margin-bottom: 1rem;
  cursor: pointer
}
</style>