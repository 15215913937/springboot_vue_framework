<template>
    <div style="height: 50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex">
        <div style="width: 100px;padding-left: 30px;font-weight: bold;color: dodgerblue"
             @click="$router.push('/')">后台管理
        </div>
        <div style="flex: 1"></div>
        <div>
            <img :src="user.avatar" alt=""
                 style="width: 30px; border-radius: 50%; position: relative; top: 10px; right: 5px">
        </div>
        <el-dropdown style="width: 100px;cursor: pointer;text-align: center">
            <span style="position: absolute;top: 18px">{{user.username}}({{ user.name}})</span>
            <template #dropdown>
                <el-dropdown-menu>
                    <el-dropdown-item @click="this.$router.push('/person')">个人信息</el-dropdown-item>
                    <el-dropdown-item @click="this.$router.push('/password')">修改密码</el-dropdown-item>
                    <el-dropdown-item @click="logout">退出系统</el-dropdown-item>
                </el-dropdown-menu>
            </template>
        </el-dropdown>
    </div>
</template>

<script>
    import {ArrowDown} from '@element-plus/icons-vue'
    import {resetRouter} from "../router";

    export default {
        name: "Header",
        props: ['user'],
        data() {
            return {
                avater: ''
            }
        },
        created() {
            let str = sessionStorage.getItem("user") || "{}"
            this.form = JSON.parse(str)
        },
        setup() {
            return {
                ArrowDown
            }
        },
        methods: {
            logout() {
                sessionStorage.removeItem("user");  // 清空缓存
                sessionStorage.removeItem("menus");
                sessionStorage.removeItem("currentPathName");
                this.$router.push('/login');
                resetRouter()  //重置路由
            }
        }
    }
</script>

<style scoped>

</style>