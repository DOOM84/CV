<template>
    <div class="container py-lg-5">
        <div class="text-center">
            <h2 class="heading text-center"><strong>{{getLang(location, 'login')}}</strong> </h2>
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
                        <div class="col-sm-12">
                            <input type="password" v-model="form.password" name="Password" :placeholder="getLang(location, 'password')" required="">
                        </div>
                    </div>
                    <div class="text-center ">
                    <button type="submit" class="btn">{{getLang(location, 'login')}}</button>
                    <button type="reset" class="btn">{{getLang(location, 'clear')}}</button>
                    <nuxt-link to="/restore" class="btn">{{getLang(location, 'forgot')}}</nuxt-link>
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
                title: this.getLang(this.location, 'sphere') + ' — ' + this.getLang(this.location, 'login')
            }
        },
        data(){
            return {
                form: {
                    email: '',
                    password: ''
                },
            }
        },
        methods: {
            onSubmit(){
                if(this.checkForm()){
                    this.login();
                }

            },
           async login(){
               try {
                   const formData = {
                       email: this.form.email,
                       password: this.form.password
                   };
                   await this.$auth.loginWith('local', {data: formData});

               }catch (e) {
                   this.loading = false
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
                if (!this.form.password) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordReq')
                    });
                    return  false
                } else if(this.form.password.length < 6){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordMin')
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
                        text: this.getLang(this.location, 'userNo')
                    });
                }
                if(this.errors.blocked){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'blocked')
                    });
                }
            }
        },

    }
</script>

<style scoped>

</style>
