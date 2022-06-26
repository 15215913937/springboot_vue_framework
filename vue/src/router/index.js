import {createRouter, createWebHistory} from 'vue-router'
import Layout from '@/layout/layout.vue'
import Login from "@/views/Login";

const routes = [
    {
        path: '/',
        name: 'Layout',
        component: Layout,
        redirect: "/home",
        children: [{
            path: 'home',
            name: 'Home',
            component: () => import("@/views/Home.vue")
        }]
    },
    {
        path: '/login',
        name: 'Login',
        component: () => import("@/views/Login.vue")
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import("@/views/Register.vue")
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
