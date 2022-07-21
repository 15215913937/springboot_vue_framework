import { createStore } from 'vuex'
import Vuex from 'vuex'
import router, {resetRouter} from "@/router";

export default createStore({
  state: {
    user: {}
  },
  mutations: {
    SET_USER(state, user) {
      state.user = user
    }
  },
  actions: {
    SET_USER({commit}, user) {
      this.state.user = user
    }
  },
  getters: {
    getUser: (state) => state.user
  }
})
export const store = new Vuex.Store({
  state: {
    currentPathName: ''
  },
  mutations: {
    // setPath (state) {
    //   state.currentPathName = sessionStorage.getItem("currentPathName")
    // },
    logout() {
      // 清空缓存
      sessionStorage.removeItem("user")
      sessionStorage.removeItem("menus")
      router.push("/login")

      // 重置路由
      resetRouter()
    }
  }
})