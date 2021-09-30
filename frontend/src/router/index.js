import { createRouter, createWebHashHistory } from "vue-router";
import Home from "../views/Home.vue";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/main",
    name: "Main",
    // route level code-splitting
    // this generates a separate chunk (main.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "main" */ "../views/Main.vue"),
    children: [
      {
        path: "feed",
        name: "Feed",
        component: () =>
          import(/* webpackChunkName: "main" */ "../views/Feed.vue"),
      },  
      {
        path: "settings",
        name: "Settings",
        component: () =>
          import(/* webpackChunkName: "main" */ "../views/Settings.vue"),
      }, 
      {
        path: "profil",
        name: "Profil",
        component: () =>
          import(/* webpackChunkName: "main" */ "../views/Profil.vue"),
      },    
    ],  
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
