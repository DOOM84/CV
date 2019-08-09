<template>
    <nav class="mnu mx-auto d-inline">
        <notifications group="foo" animation-name="v-fade-left" position="top center" />
        <label for="drop" class="toggle"><span class="fa fa-bars"></span></label>
        <input type="checkbox" id="drop">
        <ul class="menu pt-3">
            <li class="mr-lg-4 mr-3 active"><nuxt-link to="/">{{getLang(location, 'home')}}</nuxt-link></li>
            <li class="mr-lg-4 mr-3"><nuxt-link to="/#about">{{getLang(location, 'about')}}</nuxt-link></li>
            <li class="mr-lg-4 mr-3"><nuxt-link to="/#technologies">{{getLang(location, 'technologies')}}</nuxt-link></li>
            <li class="mr-lg-4 mr-3"><nuxt-link to="/#projects">{{getLang(location, 'projects')}}</nuxt-link></li>
            <li class="mr-lg-4 mr-3"><nuxt-link to="/#blog">{{getLang(location, 'blog')}}</nuxt-link></li>
          <li><nuxt-link  to="#contact" class="scroll">{{getLang(location, 'contact')}}</nuxt-link></li>
        </ul>
        <div class="float-right">
          <template v-if="$auth.user">
            <span class="text-white">{{$auth.user.name}}</span>
            <img @click="showModal = true" class="imgAva" :src="$auth.user.avatar" alt="avatar">
            <span class="text-white"><a  href="#" @click.prevent="logout">{{getLang(location, 'logOut')}}</a></span>
          </template>
          <template v-else>
            <span><nuxt-link to="/login">{{getLang(location, 'login')}}</nuxt-link></span>
            <span><nuxt-link to="/signup">{{getLang(location, 'register')}}</nuxt-link></span>
          </template>
          <span v-for="lang in langs" class="pr-1" :key="lang">
            <button :ref="lang"  @click.prevent="setLang(lang)" class="text-white btn btn-link p-0 m-0" >
              {{lang}}
            </button>
          </span>
          <transition name="fade">
            <div v-if="showModal" class="modal-mask">
              <div class="modal-container" >
                <div class="modal-header">
                  <h3>{{getLang(location, 'ch_avatar')}}</h3>
                  <span @click="showModal = false" style="cursor: pointer; font-size: large" class="text-right font-weight-bold">X</span>
                </div>
                <div class="modal-body">
                  <img style="border-radius: 50%" :src="$auth.user.avatar" alt="image" class="img-fluid">
                  <input type="file" id="file" ref="file" @change="handleFileUpload"/>
                  <button v-if="showSubmit" @click="submitFile" class="btn btn-info m-3">{{getLang(location, 'send')}}</button>
                </div>
              </div>
            </div>
          </transition>
        </div>

    </nav>
</template>

<script>
    export default {
        data(){
            return {
                langs: ['ua', 'en', 'ru'],
                showModal: false,
                showSubmit: false,
                file: ''
            }
        },
        watch: {
            errors() {
                if(this.errors.img){
                    this.$notify({
                        type: 'error',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'ava_inval')
                    });
                }
            }
        },
        methods: {
            logout(){
                this.$auth.logout()
            },
            handleFileUpload() {
                this.file = this.$refs.file.files[0];
                this.showSubmit = true
            },
            async submitFile(){

                let formData = new FormData();

                formData.append('img', this.file);

                try {
                    const data = await this.$store.dispatch('auth/addAvatar', formData);
                    await this.$auth.fetchUser();
                    this.$refs.file.value = '';
                    this.showSubmit = false;
                    this.showModal = false;
                    this.$notify({
                        type: 'success',
                        group: 'foo',
                        //title: 'Important message',
                        text: this.getLang(this.location, 'ava_succ')
                    });
                } catch (error) {
                    this.$refs.file.value = '';
                    this.showSubmit = false;
                }
            },
            checkActLang(){
                for(let i = 0; i < this.langs.length; i++){
                    if(this.$refs[this.langs[i]][0].innerText === this.location){
                        this.$refs[this.langs[i]][0].classList.remove('text-white');
                        this.$refs[this.langs[i]][0].classList.add('activeLang');
                    }else{
                        this.$refs[this.langs[i]][0].classList.remove('activeLang');
                        this.$refs[this.langs[i]][0].classList.add('text-white')
                    }
                }
            },
            setLang(lang){
                this.$cookiz.set('lang', lang, {
                    maxAge: 60 * 60 * 24 * 30
                });
                this.$store.dispatch('auth/setLocation', lang);
                this.checkActLang()

            },
        },
        mounted() {
            this.checkActLang()
        }
    }
</script>

<style lang="scss" scoped>

.imgAva{
  cursor: pointer;
  border-radius: 50%;
  width:50px !important;
}

.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, .7);
  transition: opacity .3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-container {
  min-width: 30vw;
  max-width: 80vw;
  max-height: 100vh;
  padding: 10px 20px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  overflow: auto;
}
.modal-body {
  margin: 10px 0;
}

.modal-enter,
.modal-leave {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave .modal-container {
  transform: scale(1.1);
}

.activeLang{
 color: darkred;
  }

</style>
