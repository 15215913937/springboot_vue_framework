<template>
    <div>
        <el-menu
                style="width: 180px;min-height: calc(100vh - 50px)"
                :default-active="$route.path"
                :default-openeds="[1]"
                unique-opened="true"
                router
                class="el-menu-vertical-demo"
        >
            <!--            动态菜单-->
            <div v-for="item in menus" :key="item.id">
                <div v-if="item.path">
                    <el-menu-item :index="item.path">
                        <el-icon>
                            <component :is="item.icon"/>
                        </el-icon>
                        {{item.name}}
                    </el-menu-item>
                </div>
                <div v-else>
                    <el-sub-menu :index="item.id">
                        <template #title>
                            <el-icon>
                                <component :is="item.icon"/>
                            </el-icon>
                            <span>{{item.name}}</span>
                        </template>
                        <div v-for="subItem in item.children" :key="subItem.id">
                            <el-menu-item :index="subItem.path">
                                <el-icon>
                                    <component :is="subItem.icon"/>
                                </el-icon>
                                <span>{{subItem.name}}</span>
                            </el-menu-item>
                        </div>
                    </el-sub-menu>
                </div>
            </div>
            <!--            静态菜单-->
            <!--            <el-menu-item index="/index/home">-->
            <!--                <el-icon>-->
            <!--                    <PieChart/>-->
            <!--                </el-icon>-->
            <!--                全局概览-->
            <!--            </el-menu-item>-->
            <!--            <el-sub-menu index="1">-->
            <!--                <template #title>-->
            <!--                    <el-icon>-->
            <!--                        <SetUp/>-->
            <!--                    </el-icon>-->
            <!--                    <span>事务管理</span>-->
            <!--                </template>-->
            <!--                <el-menu-item index="/index/book">-->
            <!--                    <el-icon>-->
            <!--                        <Notebook/>-->
            <!--                    </el-icon>-->
            <!--                    书籍管理-->
            <!--                </el-menu-item>-->
            <!--                <el-menu-item index="/index/events">-->
            <!--                    <el-icon>-->
            <!--                        <Ship/>-->
            <!--                    </el-icon>-->
            <!--                    事件论坛-->
            <!--                </el-menu-item>-->
            <!--                <el-menu-item index="/index/file">-->
            <!--                    <el-icon>-->
            <!--                        <Folder/>-->
            <!--                    </el-icon>-->
            <!--                    文件管理-->
            <!--                </el-menu-item>-->
            <!--            </el-sub-menu>-->
            <!--            <el-sub-menu index="2">-->
            <!--                <template #title>-->
            <!--                    <el-icon>-->
            <!--                        <Setting/>-->
            <!--                    </el-icon>-->
            <!--                    <span>系统管理</span>-->
            <!--                </template>-->
            <!--                <el-menu-item index="/index/user">-->
            <!--                    <el-icon>-->
            <!--                        <Avatar/>-->
            <!--                    </el-icon>-->
            <!--                    成员管理-->
            <!--                </el-menu-item>-->
            <!--                <el-menu-item index="/index/role">-->
            <!--                    <el-icon>-->
            <!--                        <UserFilled/>-->
            <!--                    </el-icon>-->
            <!--                    角色管理-->
            <!--                </el-menu-item>-->
            <!--                <el-menu-item index="/index/menu">-->
            <!--                    <el-icon>-->
            <!--                        <Menu/>-->
            <!--                    </el-icon>-->
            <!--                    菜单管理-->
            <!--                </el-menu-item>-->
            <!--            </el-sub-menu>-->
        </el-menu>
    </div>
</template>

<script>

    import request from "@/utils/request";

    export default {
        name: "Aside",
        data() {
            return {
                path: this.$route.path, //设置菜单按钮默认高亮效果
                user: {},
                menus: sessionStorage.getItem("menus") ? JSON.parse(sessionStorage.getItem("menus")) : []
            }
        },
        created() {
            let userStr = sessionStorage.getItem("user") || "{}";
            this.user = JSON.parse(userStr);
            //请求服务端，确认当前用户的合法信息，避免本地缓存修改数据
            request.get("/user/" + this.user.id).then(res => {
                if (res.code === '0') {
                    this.user = res.data
                }
            })
        }
    }
</script>
