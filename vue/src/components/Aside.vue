<template>
    <div>
        <el-menu
                style="width: 200px;min-height: calc(100vh - 50px)"
                default-active="book"
                :default-openeds="[1]"
                router
                class="el-menu-vertical-demo"
        >
            <el-sub-menu index="1">
                <template #title>
                    <el-icon>
                        <Notebook/>
                    </el-icon>
                    <span>书籍管理</span>
                </template>
                <el-menu-item index="book">书籍管理</el-menu-item>
            </el-sub-menu>
            <el-sub-menu index="2">
                <template #title>
                    <el-icon>
                        <Operation/>
                    </el-icon>
                    <span>系统管理</span>
                </template>
                <el-menu-item index="user">成员管理</el-menu-item>
            </el-sub-menu>

        </el-menu>
    </div>
</template>

<script>
    export default {
        name: "Aside"
    }
</script>
