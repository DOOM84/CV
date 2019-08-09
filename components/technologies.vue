<template>
    <div class="container py-lg-5">
        <h3 class="heading text-center"><strong>{{getLang(location, 'technologies')}}</strong> </h3>
        <div v-for="skill in skills" :key="skill.id" class="progress m-5 " style="height: 20px;">
            <div class="progress-bar bg-info" role="progressbar" :style="{width: skill.rate + '%'}"  :aria-valuenow="skill.rate"  aria-valuemin="0" aria-valuemax="100">
              <div class="d-inline"><span class="text-left">{{skill.name}}</span></div></div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['skills']
    }
</script>

<style scoped>

</style>
