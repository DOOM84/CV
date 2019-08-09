<template>
    <div>
        <transition name="fade">
            <div v-if="showModal" class="modal-mask" @click="showModal = false">
                <div class="modal-container" >
                    <div class="modal-header">
                        <h3 v-html="detailPr"></h3>
                        <span @click="closeModal" style="cursor: pointer; font-size: large" class="text-right font-weight-bold">X</span>
                    </div>
                    <div class="modal-body">
                        <img :src="showPr" alt="image" class="img-fluid">
                    </div>
                </div>
            </div>
        </transition>
    <div class="container py-lg-5">
        <h3 class="heading text-center"> <strong>{{getLang(location, 'projects')}}</strong> </h3>
        <div class="card-columns">
            <div v-for="project in projects" :key="project.id" class="card" style="width: 18rem; cursor: pointer">
                <img class="card-img-top" @click="showImg(project.image, project[toLang('details')])" :src="project.image" alt="image">
            </div>
        </div>
    </div>
    </div>
</template>

<script>
    export default {
        props: ['projects'],
        data(){
            return {
                showPr : '',
                detailPr : '',
                showModal: false,
            }
        },
        methods: {
            showImg(path, details) {
                this.showPr = path;
                this.detailPr = details;
                this.showModal = true
            },
            closeModal(){
                this.showModal = false
            }
        }
    }
</script>

<style scoped>
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
        min-width: 50vw;
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

</style>
