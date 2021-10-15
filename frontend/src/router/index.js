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
          import(/* webpackChunkName: "Feed" */ "../views/Feed.vue"),
      },
      {
        path: ":id",
        name: "FeedId",
        component: () =>
          import(/* webpackChunkName: "FeedId" */ "../views/PostDetails.vue"),
      },
      {
        path: "settings",
        name: "Settings",
        component: () =>
          import(/* webpackChunkName: "Settings" */ "../views/Settings.vue"),
      }, 
      {
        path: "profil",
        name: "Profil",
        component: () =>
          import(/* webpackChunkName: "Profil" */ "../views/Profil.vue"),
      },    
    ],  
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
