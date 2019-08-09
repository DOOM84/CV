<template>
<div>
  <nav aria-label="breadcrumb" class="p-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item "><nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link></li>
      <li class="breadcrumb-item active" aria-current="page">Главная страница</li>
    </ol>
  </nav>
      <div class="text-center">
        <h4>Добро пожаловать в административную панель сайта Персональный сайт А. Тищенко</h4>
        <h5>Выберите необходимое действие для управления из меню слева.</h5>
      </div>
</div>
</template>

<script>
    export default {
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Главная'
            }
        },
    }
</script>

<style scoped>

</style>
