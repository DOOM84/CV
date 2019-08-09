<template>
    <div class="container py-lg-5">
        <div class="text-center">
            <h2 class="heading text-center"><strong>{{getLang(location, 'register')}}</strong> </h2>
        </div>
        <div class="row contact-top">
            <div class="col-lg-12 contact_grid_right" style="min-height: 32vh">
                <form
                        ref="form"
                        @submit.prevent="onSubmit"
                >
                    <div class="row contact_top mb-3">
                        <div class="col-sm-12">
                            <input type="text"  v-model="form.name" name="Name" :placeholder="getLang(location, 'name')" required="">
                        </div>
                        <div class="col-sm-12">
                            <input type="email"  v-model="form.email" name="Email" :placeholder="getLang(location, 'email')" required="">
                        </div>
                        <div class="col-sm-12">
                            <input type="password" v-model="form.password" name="Password" :placeholder="getLang(location, 'password')" required="">
                        </div>
                        <div class="col-sm-12">
                            <input type="password" v-model="form.password_confirmation" name="Password_confirmation" :placeholder="getLang(location, 'password_more')"  required="">
                        </div>
                    </div>
                    <div class="text-center ">
                        <button type="submit" class="btn">{{getLang(location, 'register')}}</button>
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
                title: this.getLang(this.location, 'sphere') + ' — ' + this.getLang(this.location, 'register')
            }
        },
        data(){
            return {
                form: {
                    name: '',
                    email: '',
                    password: '',
                    password_confirmation: ''
                },
            }
        },
        methods: {
            onSubmit(){
                if(this.checkForm()){
                    this.signUp();
                }

            },
            async signUp(){
                try {
                    const formData = {
                        name: this.form.name,
                        email: this.form.email,
                        password: this.form.password,
                        password_confirmation: this.form.password_confirmation
                    };
                    await this.$axios.post('auth/register', formData);

                    await this.$auth.loginWith('local', {
                        data: {
                            email: formData.email,
                            password: formData.password
                        },
                    });
                    this.$router.push('/')
                } catch (e) {
                    this.loading = false
                }
            },
            checkForm(){
                if (!this.form.name) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'nameReq')
                    });
                    return false
                } else if (this.form.name.length < 3) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'nameMin')
                    });
                    return false
                }
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
                } else if (!this.form.password_confirmation) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordReq')
                    });
                    return  false
                }
                    else if(this.form.password.length < 6){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordMin')
                    });
                    return false
                }
                    else if(this.form.password_confirmation.length < 6){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordMin')
                    });
                    return false
                }
                else if (this.form.password !== this.form.password_confirmation) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'passwordConfirmed')
                    });
                    return  false
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
                        text: this.getLang(this.location, 'emailUnique')
                    });
                }
            }
        }

    }
</script>

<style scoped>

</style>
