import { createStore } from "vuex";

export default createStore({
  state: {
    isLoading: false,
  },
  mutations: {
    displayLoading(state){
      state.isLoading = !state.isLoading;
    },
    checkValidation(){
      if(!localStorage.getItem("authgroupomania")){
        window.location.href = window.location.origin;
      }
    },
  },
  actions: {},
  modules: {},
});
