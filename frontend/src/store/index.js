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
      account_type: '',
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
      state.user.account_ = user.account_;
    },
  },
  actions: {
    getUserInformations(context, userId){
      this.bodyUserId.userId = JSON.parse(localStorage.getItem('authgroupomania')).userId;
      fetch('http://localhost:3000/api/auth/user/'+ `${this.bodyUserId.userId}`,{
        method: 'POST',
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          "authorization" : 'Bearer' + ' ' + JSON.parse(localStorage.getItem('authgroupomania')).token,
        },
        body: JSON.stringify(this.bodyUserId),
        })
        .then(response => response.json())
        .then(userInfo => {
          this.user.lastname = userInfo.lastname;
          this.user.name = userInfo.name;
          this.user.job = userInfo.job;
          this.user.profile_picture = userInfo.profile_picture;
        })
        .catch(err=>{console.log(err)})
    },
  },
  modules: {},
});
