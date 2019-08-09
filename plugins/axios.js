export default  function ({$axios, store, app, redirect}) {

    $axios.onError(error => {
        if(error.response.status === 422){
            store.dispatch("validation/setErrors", error.response.data.errors);
            //return redirect('/login');
        }
      if(error.response.status === 404){
        return redirect('/404');
      }

        if(error.response.status === 403){
            store.dispatch("validation/setErrors", error.response.data.errors);
            //return redirect('/');
        }

        if (error.response.status === 500) {
            console.error('Server 500 error')
        }

        if (error.response.status === 401) {
            app.$auth.reset();
            return redirect('/login');
        }

        return Promise.reject(error);
    });

    $axios.onRequest(()=>{
        store.dispatch("validation/clearErrors");
    })
}
