import {createRouter, createWebHistory} from 'vue-router'
// import {forEach} from "wangeditor/dist/utils/util";

const routes = [
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
    {
        path: '/front',
        name: 'Front',
        component: () => import('../views/front/Front'),
        children: [
            {
                path: 'home',
                name: 'FrontHome',
                component: () => import('../views/front/Home'),
            },
        ]
    },

]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})
//注意，刷新页面会导致页面重置
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
                {path: 'person', name: 'Person', component: () => import("@/views/Person")},
                {path: 'password', name: 'Password', component: () => import("@/views/Password")},]
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
// export const resetRouter = () => {
//     router.matcher = new VueRouter({
//         mode: 'history',
//         base: process.env.BASE_URL,
//         routes
//     })
// }
// 重置我就再set一次路由
setRoutes()
//路由守卫，路由跳转前进行操作
router.beforeEach((to, from, next) => {
    let user = JSON.parse(sessionStorage.getItem("user")); //获取用户信息
    // sessionStorage.setItem("currentPathName", to.name)
    // let currentPath = JSON.parse(sessionStorage.getItem("currentPathName"));
    // 设置当前的路由名称
    // 未找到路由的情况
    // if (!to.matched.length) {
    //     const storeMenus = sessionStorage.getItem("menus")
    //     if (storeMenus) {
    //         next("/404")
    //     } else {
    //         // 跳回登录页面
    //         next("/login")
    //     }
    // }
    if (!user && to.path !== '/login') {
        next('/login')
    } else {
        // 其他的情况都放行
        next()
    }


})
export default router
