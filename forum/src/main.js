import Vue from 'vue'
import ElementUI from 'element-ui'
import axios from 'axios'
import App from './App'
import router from './router'
import store from './store'

import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false

Vue.use(ElementUI)

axios.defaults.withCredentials = true
Vue.prototype.$http = axios

router.beforeEach((to, from, next) => {
  // eslint-disable-next-line
  if (to.path != '/login') {
    axios.post('http://172.29.35.3:3000/ifLogin')
      .then((response) => {
        if (response.data.errno === 2) {
          store.dispatch('login', response.data)
        }
        if (store.state.islogin) {
          next()
        } else {
          next('/login')
        }
      })
      .catch((err) => {
        console.log(err)
      })
  } else {
    next()
  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
