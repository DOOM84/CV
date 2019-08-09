<template>
  <div>
    <nav aria-label="breadcrumb" class="p-3">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <nuxt-link style="color: black; padding: 0;" to="/admin">Панель управления</nuxt-link>
        </li>
        <li class="breadcrumb-item" aria-current="page">
          <nuxt-link style="color: black; padding: 0;" to="/admin/posts">Посты (блог)</nuxt-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Добавить пост</li>
      </ol>
    </nav>
    <form @submit.prevent="onSubmit">

      <div class="form-group">
        <label>Название</label>
        <input v-model="controls.title" type="text" class="form-control" placeholder="Название">
      </div>

      <div class="form-group">
        <label>Название (англ.)</label>
        <input v-model="controls.en_title" type="text" class="form-control" placeholder="Название (англ.)">
      </div>

      <div class="form-group">
        <label>Описание</label>
        <input v-model="controls.subtitle" type="text" class="form-control" placeholder="Описание">
      </div>

      <div class="form-group">
        <label>Описание (англ.)</label>
        <input v-model="controls.en_subtitle" type="text" class="form-control" placeholder="Описание (англ.)">
      </div>


    <label>Текст</label>
    <!--<no-ssr >
      <ckeditor  type="classic" v-model="controls.body" :upload-adapter="UploadAdapter"></ckeditor>
    </no-ssr>-->
      <tinymce-editor v-model="controls.body" api-key='jzo2eedwn9qet3a83dmrcy1mbs31gdymmkcqi1rvyok6bzu6' :init="init"></tinymce-editor>

      <div class="form-group pt-3">

        <multiselect
          v-model="controls.categories"
          :options="categories"
          :multiple="true"
          :close-on-select="false"
          :clear-on-select="false"
          :hide-selected="false"
          :preserve-search="false"
          placeholder="Выберите категорию"
          label="name"
          track-by="name"
          :preselect-first="false"
          id="id"

        ></multiselect>
      </div>

      <div class="form-group pt-3">
        <label>Ресурс</label>
        <input v-model="controls.source" type="text" class="form-control" placeholder="Ресурс">
      </div>

      <div class="custom-control custom-switch">
        <input type="checkbox" v-model="controls.status" class="custom-control-input" id="customSwitch1">
        <label class="custom-control-label" for="customSwitch1">Опубликовано</label>
      </div>

    <div class="form-group pt-3">
      <label>Изображение</label>
      <input class="w-100" type="file" id="file" ref="file" @change="handleFileUpload"/>
    </div>
      <div class="form-group pb-3 text-center">
      <button type="submit" class="btn btn-success m-3 w-25">Добавить</button>
      </div>

    </form>

  </div>
</template>

<script>
    import Editor from '@tinymce/tinymce-vue';
    export default {
        layout: 'admin',
        head(){
            return {
                title: 'Панель управления — Добавить пост'
            }
        },
        components: {
            'tinymce-editor': Editor, // <- Important part
        },

        data() {
            return {
                init:{
                    selector: 'textarea',
                    height: 500,
                    plugins: 'print preview powerpaste searchreplace autolink directionality advcode visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists  wordcount tinymcespellchecker a11ychecker imagetools mediaembed  linkchecker  textpattern help',
                    toolbar1: 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat',
                    images_upload_handler: function (blobInfo, success, failure) {
                        const data = new FormData();
                        data.append( 'file', blobInfo.blob());
                        $nuxt.$axios( {
                            url: 'imgPost',
                            method: 'post',
                            data,
                            headers: {
                                'Content-Type': 'multipart/form-data;'
                            },
                            withCredentials: false
                        } ).then( response => {
                            if ( response.data.result === 'success' ) {
                                success('/images/blog/'+response.data.url);
                            } else {
                                console.log(response.data.message);
                            }
                        } ).catch( response => {
                            console.log( 'Upload failed' );
                        } );


                       /* setTimeout(function () {
                            /!* no matter what you upload, we will turn it into TinyMCE logo :)*!/
                            success('http://moxiecode.cachefly.net/tinymce/v9/images/logo.png');
                        }, 2000);*/

                    }
                    },
                file: '',
                image: '',
                controls: {
                    title: '',
                    en_title: '',
                    body: '',
                    categories: [],
                    subtitle: '',
                    en_subtitle: '',
                    source: '',
                    status: false,
                },
                categories: '',

               /* UploadAdapter: function (loader) {
                    this.loader = loader;

                    this.upload = () => {
                        return this.loader.file
                            .then( uploadedFile => {
                                return new Promise( ( resolve, reject ) => {
                                    const data = new FormData();
                                    data.append( 'file', uploadedFile );

                                    $nuxt.$axios( {
                                        url: 'imgPost',
                                        method: 'post',
                                        data,
                                        headers: {
                                            'Content-Type': 'multipart/form-data;'
                                        },
                                        withCredentials: false
                                    } ).then( response => {
                                        if ( response.data.result === 'success' ) {
                                            resolve( {
                                                default: '/images/blog/'+response.data.url
                                            } );
                                        } else {
                                            console.log(response.data.message);
                                            //reject( response.data.message );
                                        }
                                    } ).catch( response => {
                                        console.log( 'Upload failed' );
                                    } );

                                } );
                            } );
                    }
                }*/
            }
        },
        async asyncData({store}) {
            try {
                const {categories} = await store.dispatch('adminPost/edit');
                //console.log(categories);
                return {
                    categories
                }
            } catch (error) {
                if (error.response.status === 401) {
                    return $nuxt.$router.replace('/login');
                }
            }
        },
        methods: {
            async onSubmit() {
                const formData = new FormData();
                for (let elem in this.controls) {
                    if(elem === 'categories'){formData.append(elem, JSON.stringify(this.filterItem(this.controls.categories)))}
                   else{ formData.append(elem, JSON.stringify(this.controls[elem]));}
                }
                formData.append('image', this.image);
                //formData.append('_method', 'POST');
                        try {
                            const {success} = await this.$store.dispatch('adminPost/create', formData);
                            this.$notify({
                                type: 'success',
                                group: 'foo',
                                text: success
                            });
                            this.$router.push('/admin/posts')
                        } catch (e) {
                            console.log(e);
                        }
            },
            filterItem(objArr){
                let result = [];
                for (let i = 0; i < objArr.length; i++) {
                    if (typeof objArr[i] === 'object' && objArr[i].constructor === Object) {
                        result.push(objArr[i].id);
                    }
                }
                return result.length > 0 ? result : objArr;
            },
            handleFileUpload() {
                this.image = this.$refs.file.files[0];
            },
        },
    }

</script>

<style scoped>

</style>
