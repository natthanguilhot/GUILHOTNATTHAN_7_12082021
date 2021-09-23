import { createStore } from "vuex";

export default createStore({
  state: {
    isLoading: false,
  },
  mutations: {
    displayLoading(state){
      state.isLoading = !state.isLoading;
    }
  },
  actions: {},
  modules: {},
});
