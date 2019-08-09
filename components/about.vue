<template>
    <section class="news" id="about">
        <div class="container py-lg-5">
            <div class="text-center">
                <h3 class="heading text-center"> {{getLang(location, 'about')}} </h3>
            </div>
            <div class="row contact-top">
                <div class="col-lg-6 contact_grid_right">
                    <p>
                      {{getLang(location, 'about_work')}}
                    </p>
                </div>
                <div class="col-lg-6 ">
                    <p class="mb-4">{{getLang(location, 'information')}}</p>
                    <div class="row">
                        <div class="col-lg-12 ">
                            <ul class="list-unstyled">
                                <li>
                                    <div class="row">
                                        <div class="col-4">
                                            <span>{{getLang(location, 'city_country')}}:</span>
                                        </div>
                                        <div class="col-8">
                                            <p>{{getLang(location, 'city_country_name')}}</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="mt-3">
                                    <div class="row">
                                        <div class="col-4">
                                            <span>{{getLang(location, 'age')}}:</span>
                                        </div>
                                        <div class="col-8">
                                            <p>{{age}}</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="mt-3">
                                    <div class="row">
                                        <div class="col-4">
                                            <span>{{getLang(location, 'languages')}}:</span>
                                        </div>
                                        <div class="col-8">
                                           <p>{{getLang(location, 'langs')}}</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 mx-auto tl p-3 mt-5">
                        <h3 class="p-3 text-white"  >{{getLang(location, 'experience')}}</h3>

                        <!-- Timeline -->
                        <ul class="timeline">
                            <li v-for="item in exp" :key="item.id"  class="timeline-item bg-white rounded ml-3 p-4 shadow">
                                <div class="timeline-arrow"></div>
                                <h2 class="h5 mb-0">
                                  {{item[toLang('seat')]}}
                                  {{item[toLang('description')]}}
                                </h2>
                              <span class="small text-gray">
                                <i class="fa fa-clock-o mr-1"></i>
                                {{item[toLang('start')]}} - {{item[toLang('end')]}}
                              </span>
                                <p class="text-small mt-2 font-weight-light">
                                  {{item[toLang('company')]}}
                                </p>
                            </li>
                        </ul>
                        <h3 class="p-3 text-white">{{getLang(location, 'education')}}</h3>

                        <!-- Timeline -->
                        <ul class="timeline">
                            <li v-for="item in edu" :key="item.id" class="timeline-item bg-white rounded ml-3 p-4 shadow">
                                <div class="timeline-arrow"></div>
                                <h2 class="h5 mb-0">
                                  {{item[toLang('univer')]}}
                                  {{item[toLang('faculty')]}}
                                </h2><span class="small text-gray"><i class="fa fa-clock-o mr-1"></i>{{item.start}} - {{item.end}}</span>
                                <p class="text-small mt-2 font-weight-light">
                                  {{item[toLang('details')]}}
                                </p>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>

        </div>
    </section>
</template>

<script>
    export default {
        props: ['exp', 'edu', 'age'],
    }
</script>

<style lang="scss" scoped>
    .tl{
        background: #E8CBC0;
        background: -webkit-linear-gradient(to right, #373B44, #4286f4);
        background: linear-gradient(to right, #373B44, #4286f4);
    }
    ul.timeline {
        list-style-type: none;
        position: relative;
        padding-left: 1.5rem;
    }

    /* Timeline vertical line */
    ul.timeline:before {
        content: ' ';
        background: #fff;
        display: inline-block;
        position: absolute;
        left: 16px;
        width: 4px;
        height: 100%;
        z-index: 400;
        border-radius: 1rem;
    }

    li.timeline-item {
        margin: 20px 0;
    }

    /* Timeline item arrow */
    .timeline-arrow {
        border-top: 0.5rem solid transparent;
        border-right: 0.5rem solid #fff;
        border-bottom: 0.5rem solid transparent;
        display: block;
        position: absolute;
        left: 2rem;
    }

    /* Timeline item circle marker */
    li.timeline-item::before {
        content: ' ';
        background: #ddd;
        display: inline-block;
        position: absolute;
        border-radius: 50%;
        border: 3px solid #fff;
        left: 11px;
        width: 14px;
        height: 14px;
        z-index: 400;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }
</style>
