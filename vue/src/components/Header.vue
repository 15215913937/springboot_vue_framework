<template>
    <div style="height: 50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex">
        <div style="width: 100px;padding-left: 30px;font-weight: bold;color: dodgerblue">后台管理</div>
        <div style="flex: 1"></div>
        <div style="width: 100px;padding-top: 15px ">
            <el-dropdown>
          <span class="el-dropdown-link">
            小沈<el-icon class="el-icon-arrow-right el-icon--right"></el-icon>
          </span>
                <template #dropdown>
                    <el-dropdown-menu>
                        <el-dropdown-item @click="this.$router.push('/person')">个人信息</el-dropdown-item>
                        <el-dropdown-item @click="this.$router.push('/login')">退出系统</el-dropdown-item>
                    </el-dropdown-menu>
                </template>
            </el-dropdown>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Header"
    }
</script>

<style scoped>

</style>