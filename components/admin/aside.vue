<template>
    <div class="sidebar-sticky">
      <ul class="nav flex-column">
        <li class="nav-item">
          <nuxt-link exact class="nav-link" to="/admin">
            <span class="fa fa-tachometer pr-1"></span>
            Панель управления
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/skills">
            <span class="fa fa-globe pr-1"></span>
            Технологии
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/works">
            <span class="fa fa-briefcase pr-1"></span>
            Места работы
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/education">
            <span class="fa fa-university pr-1"></span>
            Образование
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/projects">
            <span class="fa fa-tasks pr-1"></span>
            Проекты
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/categories">
            <span class="fa fa-th-large pr-1"></span>
            Категории (блог)
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/posts">
            <span class="fa fa-pencil-square pr-1"></span>
            Посты (блог)
          </nuxt-link>
        </li>
        <li class="nav-item">
          <nuxt-link class="nav-link" to="/admin/users">
            <span class="fa fa fa-users pr-1"></span>
            Пользователи
          </nuxt-link>
        </li>
      </ul>
    </div>
</template>

<script>
    export default {
    }
</script>

<style scoped>

</style>
