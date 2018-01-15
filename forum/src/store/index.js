import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    islogin: false,
    user: {}
  },
  mutations: {
    login (state) {
      state.islogin = true
    },
    logout (state) {
      state.islogin = false
    },
    setUser (state, u) {
      state.user = u
    }
  },
  getters: {},
  actions: {
    login ({commit}, obj) {
      commit('login')
      commit('setUser', obj.user)
    },
    logout ({commit}) {
      commit('logout')
      commit('setUser', {})
    }
  }
})
