<template>
    <div class="container py-lg-5">
        <div class="text-center">
            <h2 class="heading text-center"><strong>{{getLang(location, 'resetPas')}}</strong> </h2>
        </div>
        <div class="row contact-top">
            <div class="col-lg-12 contact_grid_right" style="min-height: 32vh">
                <form
                        ref="form"
                        @submit.prevent="onSubmit"
                >
                    <div class="row contact_top mb-3">
                        <div class="col-sm-12">
                            <input type="email"  v-model="form.email" name="Email" :placeholder="getLang(location, 'email')" required="">
                        </div>
                    </div>
                    <div class="text-center ">
                    <button type="submit" class="btn">{{getLang(location, 'resetPas')}}</button>
                    <button type="reset" class="btn">{{getLang(location, 'clear')}}</button>
                    </div>
                    <div class="clearfix"> </div>
                </form>
            </div>

        </div>

    </div>
</template>

<script>
    export default {
        middleware: ['guest'],
        head(){
            return {
                title: this.getLang(this.location, 'sphere') + ' — ' + this.getLang(this.location, 'resetPas')
            }
        },
        data(){
            return {
                form: {
                    email: '',
                },
            }
        },
        methods: {
            onSubmit(){
                if(this.checkForm()){
                    this.restore();
                }

            },
           async restore(){
               try {
                   await this.$store.dispatch('auth/restore', this.form);
                   this.$notify({
                       type: 'success',
                       group: 'foo',
                       text: this.getLang(this.location, 'sentMail')
                   });
               }catch (e) {
               }
            },
            checkForm(){
                if (!this.form.email) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'emailReq')
                    });
                    return false
                } else if (!this.validEmail(this.form.email)) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'emailEm')
                    });
                    return false
                }
                return true;

            },
            validEmail(email) {
                const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(email);
            }
        },
        watch: {
            errors() {
                if(this.errors.email){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'emailNoEx')
                    });
                }
            }
        },

    }
</script>

<style scoped>

</style>
