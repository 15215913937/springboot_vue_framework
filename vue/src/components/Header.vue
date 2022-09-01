<template>

    <div style="height: 50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex">
        <div style="width: 180px;  text-align: center;" @click="$router.push('/')">
            <span class="titleName">SQN系统管理</span>
        </div>
        <div style="flex: 1" class="weather">
            <!--      和风天气插件-->
            <div id="he-plugin-simple"></div>
        </div>
        <div>
            <img :src="user.avatar" alt=""
                 style="width: 30px; border-radius: 50%; position: relative; top: 10px; right: 5px">
        </div>
        <el-dropdown style="width: 150px;cursor: pointer;text-align: center">
            <span style="position: absolute;top: 18px">{{ user.username }}({{ user.name }})</span>
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

    export default {
        name: "Header",
        props: ['user'],
        data() {
            return {
                avatar: "",
            }
        },
        created() {
            let str = sessionStorage.getItem("user") || {};
            this.form = JSON.parse(str);
        },
        setup() {
            return {
                ArrowDown
            }
        },
        mounted() {
            window.WIDGET = {
                "CONFIG": {
                    "modules": "21034",
                    "background": "1",
                    "tmpColor": "FFFFFF",
                    "tmpSize": "16",
                    "cityColor": "FFFFFF",
                    "citySize": "16",
                    "aqiColor": "FFFFFF",
                    "aqiSize": "16",
                    "weatherIconSize": "24",
                    "alertIconSize": "18",
                    "padding": "10px 10px 10px 10px",
                    "shadow": "0",
                    "language": "auto",
                    "borderRadius": "5",
                    "fixed": "true",
                    "vertical": "center",
                    "horizontal": "center",
                    "left": "180",
                    "top": "3",
                    "key": "af9a153d00174b4682bd2acd5761b695"
                }
            }
            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = "https://widget.qweather.net/simple/static/js/he-simple-common.js?v=2.0";
            document.getElementById('he-plugin-simple').appendChild(script);
        },
        methods: {
            logout() {
                sessionStorage.removeItem("user");  // 清空缓存
                sessionStorage.removeItem("menus");
                sessionStorage.removeItem("currentPathName");
                this.$router.push('/login');
                // resetRouter()  //重置路由
            }
        },
    }
</script>
<style scoped>
    .titleName {
        font-size: 20px;
        font-weight: bold;
        color: dodgerblue;
    }

    .weather {
        z-index: 999999;
    }
</style>