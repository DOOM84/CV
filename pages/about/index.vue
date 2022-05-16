<template>
  <main id="about" class="withFooter">
    <h1 class="lg-heading">
      {{ $t('about_me.about') }}
      <span class="text-secondary">{{ $t('about_me.me') }}</span>
    </h1>
    <h2 class="sm-heading">
      {{ $t('my_info') }}
    </h2>
    <div class="about-info">
      <img :src="'/img/portrait.png'" alt="hero" class="bio-image">
      <div class="bio">
        <h3 class="text-secondary">BIO</h3>
        <p>
          {{ $t('about_work') }} {{ $t('city_country') }}: {{ $t('city_country_name') }}. {{ $t('age') }}:
          {{ $showAge() }}.
          {{ $t('languages') }}: {{ $t('langs') }}.
        </p>
      </div>

      <TheSkeleton v-if="pending" v-for="i in 4"></TheSkeleton>
      <AboutAbItem v-else v-for="(fact, i) in data.facts" :fact="fact" :cls="cls(i)"/>


    </div>
  </main>
</template>

<script setup>

const {data, error, pending} = await useLazyAsyncData('about', () => $fetch('/api/about'),
    {initialCache: false})

const {$t} = useNuxtApp();

const title = computed(() => $t('sphere') + ' — ' + $t('about'))

useHead({
  title: title
})

function cls(i) {
  return i + 1 !== data.value.facts.length ? 'job-' + (+i + 1) : '';
}

</script>
