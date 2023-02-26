<template>

  <div style="height: 50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex;justify-content:space-between">
    <div style="width: 180px;text-align: center" @click="$router.push('/')">
      <span class="titleName">SQN系统管理</span>
    </div>
    <div>

    </div>
    <div style="display: flex;">
      <div style="width: 50px;padding: 10px">
        <img :src="user.avatar" alt="" style="height:30px;width: 30px; border-radius: 50%;">
      </div>
      <div style="flex: 1">
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
    </div>
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
  methods: {
    logout() {
      sessionStorage.clear()
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

</style>