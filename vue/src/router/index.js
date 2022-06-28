import {createRouter, createWebHistory} from 'vue-router'
import Layout from '@/layout/layout.vue'
import Login from "@/views/Login";

const routes = [
    {
        path: '/',
        name: 'Layout',
        component: Layout,
        redirect: "/book",
        children: [{
            path: 'user',
            name: 'User',
            component: () => import("@/views/User.vue")
        },
            {
                path: 'book',
                name: 'Book',
                component: () => import("@/views/Book.vue")
            },
            {
                path: 'person',
                name: 'Person',
                component: () => import("@/views/Person.vue")
            }
        ]
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
