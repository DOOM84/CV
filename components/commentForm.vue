<template>
    <div class="comment-top">
        <h4>{{getLang(location, 'leave_com')}}</h4>
        <div class="comment-bottom">
            <form
                  ref="form"
                  @submit.prevent="onSubmit"

            >
              <span v-if="answer"><span style="color: darkgray">
                {{getLang(location, 'answer_to')}}:</span> {{answer.author}} <span style="color: darkgray">{{getLang(location, 'from')}}:</span> {{answer.date}}
              <button @click.prevent="$store.commit('auth/SET_ANSWER', null)" class="btn btn-link">{{getLang(location, 'remove_ans')}}</button>
              </span>
                <textarea style="resize: vertical; " class="form-control" v-model.trim="form.body" name="Body" :placeholder="getLang(location, 'comment')" required=""></textarea>
                <button type="submit" class="btn btn-primary submit">{{getLang(location, 'send')}}</button>
            </form>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['postId'],
        data(){
            return {
                scroll: null,
                form: {
                    body: ''
                },
            }
        },
        methods: {
            onSubmit(){
                if(this.checkForm()){
                    this.sendComment()
                }

            },
            checkForm(){
                if (!this.form.body) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'mes_req')
                    });
                    return  false
                }
                return true;
            },
            async sendComment(){
                try {
                    const {comment} = await this.$store.dispatch('auth/comment',
                        {
                            'post_id':this.postId,
                            'parent_id': this.answer ? this.answer.id : null,
                            'body': this.form.body
                        });
                    this.$store.commit('auth/SET_ANSWER', null);
                    this.$store.commit('auth/SET_ADDED_ANSWER', comment);
                    this.form.body = '';

                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        text: this.getLang(this.location, 'add_com')
                    });
                }catch (error) {

                }
            }
        },
        computed: {
                answer(){
                  return this.$store.getters['auth/answer']
            }
        }
    }
</script>

<style scoped>

</style>
