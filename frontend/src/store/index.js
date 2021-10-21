import { createStore } from "vuex";

export default createStore({
  state: {
    isLoading: false,
    user: {
      id: '',
      name: '',
      lastName: '',
      profile_picture: '',
      job: '',
      account_type: false,
    },
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
    changeUserState(user){
      state.user.id = user.id;
      state.user.name = user.name;
      state.user.lastName = user.lastName;
      state.user.profile_picture = user.profile_picture;
      state.user.job = user.job;
      state.user.account_type = user.account_type;
    },
  },
  actions: {
    getUserInformations(context){
      context.state.user.id = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      let userId = context.state.user.id;
      let body = {
        userId : context.state.user.id,
      }
      fetch('http://localhost:3000/api/auth/user/'+ `${userId}`,{
        method: 'POST',
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
        },
        body: JSON.stringify(body),
        })
        .then(response => response.json())
        .then(userInfo => {
          context.state.user.lastname = userInfo.lastname;
          context.state.user.name = userInfo.name;
          context.state.user.job = userInfo.job;
          context.state.user.profile_picture = userInfo.profile_picture;
          context.state.user.account_type = userInfo.account_type;
        })
        .catch(err=>{console.log(err)})
    },
  },
  modules: {},
});
