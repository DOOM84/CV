<template>
    <div>
    <section class="contact py-5" id="contact">
        <div class="container py-lg-5">
            <div class="text-center">
                <h2 class="heading text-center">{{getLang(location, 'quest_com')}} <strong>{{getLang(location, 'contacts')}}:</strong> </h2>
            </div>
            <div class="row contact-top">
                <div class="col-lg-6 contact_grid_right">
                    <form
                            ref="form"
                            @submit.prevent="onSubmit"
                    >
                        <div class="row contact_top">
                            <div class="col-sm-6">
                                <input type="text" v-model="form.name" name="Name" :placeholder="getLang(location, 'name')" required="">
                            </div>
                            <div class="col-sm-6">
                                <input type="email"  v-model.trim="form.contEmail" name="Email" placeholder="Email" required="">
                            </div>
                          <div class="col-sm-12">
                            <input type="tel"  v-model.trim="form.phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" name="Phone" :placeholder="getLang(location, 'phone') + ' (123-456-7890)'">
                          </div>
                        </div>
                        <textarea name="Message" v-model.trim="form.message" :placeholder="getLang(location, 'message')" required=""></textarea>
                        <button type="submit" class="btn">{{getLang(location, 'send')}} </button>
                        <button type="reset" class="btn">{{getLang(location, 'clear')}}</button>
                        <div class="clearfix"> </div>
                    </form>
                </div>
                <div class="col-lg-6 contact_grid_left pt-3">
                    <div class="row">
                      <div class="col-lg-12">
                      <div class="mapouter">
                        <div class="gmap_canvas">
                          <iframe
                            id="gmap_canvas"
                            width="100%"
                            height="300px"
                            src="https://maps.google.com/maps?q=Kyiv&t=&z=13&ie=UTF8&iwloc=&output=embed"
                            frameborder="0"
                            scrolling="no"
                            marginheight="0"
                            marginwidth="0"
                          />
                        </div>
                      </div>
                      </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <!-- //contact -->
    <div class="cpy-right text-center">
        <div class="container">
            <p class="py-md-5 py-4">© {{ new Date().getFullYear() }} | <small><small>Design by
              <a href="http://w3layouts.com"> W3layouts.</a></small></small>
            </p>
        </div>
    </div>
    </div>
</template>

<script>
    export default {
        data(){
            return {
                form: {
                    contEmail: this.$auth.user.email ? this.$auth.user.email : '',
                    name: this.$auth.user.name ? this.$auth.user.name : '',
                    message: '',
                    phone: '',
                },
            }
        },
        watch: {
            errors() {
                if(this.errors.contEmail){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'emailEm')
                    });
                }
                if(this.errors.name){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'nameReq')
                    });
                }

                if(this.errors.message){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'mes_req')
                    });
                }
                if(this.errors.phone){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'phone_inv')
                    });
                }
            }
        },
        methods: {
            onSubmit(){
                if(this.checkForm()){
                    this.contact()
                }
            },

            async contact(){
                try {
                    await this.$store.dispatch('auth/contact', this.form);
                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        text: this.getLang(this.location, 'mes_succ')
                    });
                }catch (e) {
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
                    return  false
                }
                else if(this.form.name.length < 3){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'nameMin')
                    });
                    return false
                }else if(this.form.name.length > 100){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'nameMax')
                    });
                    return false
                }

                if(!this.form.phone){

                }else if(!this.validPhone(this.form.phone)){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'phone_inv')
                    });
                    return false
                }
                if (!this.form.contEmail) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'emailReq')
                    });
                    return false
                } else if (!this.validEmail(this.form.contEmail)) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'emailEm')
                    });
                    return false
                }
                if (!this.form.message) {
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        text: this.getLang(this.location, 'mes_req')
                    });
                    return  false
                } else if(this.form.message.length < 10){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'mesMin')
                    });
                    return false
                } else if(this.form.message.length > 1000){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'mesMax')
                    });
                    return false
                }
                return true;

            },
            validEmail(email) {
                const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(email);
            },

            validPhone(phone){
                const re = /^(\([0-9]{3}\)\s*|[0-9]{3}\-)[0-9]{3}-[0-9]{4}$/;
                return re.test(phone);
            }
        }

    }
</script>

<style scoped>

</style>
