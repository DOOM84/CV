<template>
  <div>
  <div :id="'comment' + comment.id" v-for="comment in comments[id]" :key="comment.id" class="media mb-2">
    <img :src="'/images/avatars/' + comment.owner.avatar.img" alt="" class="img-fluid rounded " />
    <div class="media-body">
      <h5 class="mt-0">{{comment.owner.name}} <span style="color: darkgray"> {{comment.created_at}}</span>
        <button  @click="remove(comment.id)" class="btn btn-link">
                <span class="fa fa-trash"></span>
        </button>
      </h5>
      <p class="mb-3">{{comment.body}}</p>
      <admin-comments  v-if="comments[comment.id]"  :comments="comments" :id="comment.id"/>
    </div>
  </div>
  </div>
</template>

<script>
    export default {
        name: "adminComments",
        props: ['comments', 'id'],
        methods: {
            async remove(comment){
                if (confirm('Are You Sure?')){
                    const {comments} = await this.$store.dispatch('adminPost/delCom',
                     {comment: comment, post: this.$route.params.post.slug});
                    this.$store.commit('adminPost/SET_COMMENTS', comments);
                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        text: 'Комментарий успешно удален'
                    });
                }
            }
        }
    }
</script>

<style scoped>

</style>
