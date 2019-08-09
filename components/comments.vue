<template>
  <div>
  <div :id="'comment' + comment.id" v-for="comment in comments[id]" :key="comment.id" class="media">
    <img :src="'/images/avatars/' + comment.owner.avatar.img" alt="" class="img-fluid rounded" />
    <div class="media-body">
      <h5 class="mt-0">{{comment.owner.name}} <span style="color: darkgray"> {{comment.created_at}}</span>
        <button v-if="$auth.loggedIn" @click="answer(comment)" class="btn btn-link"
                v-scroll-to="{ el: '#commentForm', offset: -200 }">
          {{getLang(location, 'to_answer')}}
        </button>
      </h5>
      <p>{{comment.body}}</p>
      <comments  v-if="comments[comment.id]"  :comments="comments" :id="comment.id"/>
    </div>
  </div>
  </div>
</template>

<script>
    export default {
        name: "comments",
        props: ['comments', 'id'],
        methods: {
            answer(comment){
                this.$store.commit('auth/SET_ANSWER',
                    {author: comment.owner.name, date: comment.created_at, id: comment.id})
            }
        }
    }
</script>

<style scoped>

</style>
