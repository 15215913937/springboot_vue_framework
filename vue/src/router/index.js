import {createRouter, createWebHistory} from 'vue-router'
// import {forEach} from "wangeditor/dist/utils/util";

const routes = [
    // {
    //     path: '/',
    //     name: 'Layout',
    //     component: () => import("@/layout/Layout"),
    //     redirect: '/home',
    //     children: [
    //         {path: 'home', name: 'Home', component: () => import("@/views/Home")},
    //         {path: 'book', name: 'Book', component: () => import("@/views/Book"),},
    //         {path: 'user', name: 'User', component: () => import("@/views/User"),},
    //         {path: 'events', name: 'Events', component: () => import("@/views/Events"),},
    //         {path: 'person', name: 'Person', component: () => import("@/views/Person"),},
    //         {path: 'file', name: 'File', component: () => import("@/views/File")},
    //         {path: 'role', name: 'Role', component: () => import("@/views/Role")},
    //         {path: 'menu', name: 'Menu', component: () => import("@/views/Menu")},
    //     ]
    // },
    {
        path: '/login',
        name: 'Login',
        component: () => import("@/views/Login")
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import("@/views/Register")
    },
    {
        path: '/404',
        name: '404',
        component: () => import('../views/404.vue')
    },

]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export const setRoutes = () => {
    const storeMenus = sessionStorage.getItem("menus");
    if (storeMenus) {
        //拼装动态路由
        const manageRoute = {
            path: '/',
            name: 'Layout',
            component: () => import("@/layout/Layout"),
            redirect: '/home',
            children: [
                {path: 'person', name: 'Person', component: () => import("@/views/Person")}]
        };
        const menus = JSON.parse(storeMenus);
        menus.forEach(item => {
            if (item.path) {
                let itemMenu = {
                    path: item.path.replace("/", ""),
                    name: item.name,
                    component: () => import("@/views/" + item.pagePath + ".vue")
                };
                manageRoute.children.push(itemMenu);
            } else if (item.children.length) {
                item.children.forEach(item => {
                    if (item.path) {
                        let itemMenu = {
                            path: item.path.replace("/", ""),
                            name: item.name,
                            component: () => import("@/views/" + item.pagePath + ".vue")
                        };
                        manageRoute.children.push(itemMenu);
                    }
                })
            }
        });
        //路由添加到现在的路由对象去
        router.addRoute(manageRoute);
    }
}
// 提供一个重置路由的方法
export const resetRouter = () => {
    router.matcher = new VueRouter({
        mode: 'history',
        base: process.env.BASE_URL,
        routes
    })
}
// 重置我就再set一次路由
setRoutes()

router.beforeEach((to, from, next) => {
    sessionStorage.setItem("currentPathName", to.name)  // 设置当前的路由名称
    // store.commit("setPath")

    // 未找到路由的情况
    if (!to.matched.length) {
        const storeMenus = localStorage.getItem("menus")
        if (storeMenus) {
            next("/404")
        } else {
            // 跳回登录页面
            next("/login")
        }
    }
    // 其他的情况都放行
    next()

})
export default router
