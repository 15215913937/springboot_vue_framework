import {createRouter, createWebHistory} from 'vue-router'
import Layout from "@/layout/Layout";

const routes = [
    {
        path:'/',
        redirect: '/login'
    },
    {
        path: '/index',
        name:'Layout',
        component:Layout,
        redirect:'/index/book',
        children: [
            {
                path: 'book',
                name: 'Book',
                component: () => import("@/views/Book"),
            },
            {
                path: 'user',
                name: 'User',
                component: () => import("@/views/User"),
            },
            {
                path: 'events',
                name: 'Events',
                component: () => import("@/views/Events"),
            }
        ]
    },
    {
        path: '/login',
        name: 'Login',
        component: () => import("@/views/Login")
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import("@/views/Register")
    }

]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})
export default router
