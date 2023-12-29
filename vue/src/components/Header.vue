<template>

  <div
      style="height: 50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex;justify-content:space-between">
    <div style="width: 180px;text-align: center" @click="$router.push('/')">
      <span class="titleName">SQN系统管理</span>
    </div>
    <div style="height: 20px;font-family: 幼圆;font-size: x-large">
      {{ newTime }}
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
import request from "@/utils/request";

const days = ['天', '一', '二', '三', '四', '五', '六']; // 星期数组
let icnow = new Date();      // 初始化时间
let interval;                // 定义全局定时器，用于清除定时器

export default {
  name: "Header",
  props: ['user'],
  data() {
    return {
      avatar: '',
      year: icnow.getFullYear(),
      month: icnow.getMonth() + 1,
      date: icnow.getDate(),
      day: days[icnow.getDay() - 1],
      time: icnow.toTimeString().substring(0, 8),
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || {};
    this.form = JSON.parse(str);

    interval = setInterval(() => {
      let icnow = new Date();
      this.year = icnow.getFullYear();
      this.month = icnow.getMonth() + 1;
      this.date = icnow.getDate();
      this.day = days[icnow.getDay()];
      this.time = icnow.toTimeString().substring(0, 8);
    }, 1000)
  },
  setup() {
    return {
      ArrowDown
    }
  },
  methods: {
    logout() {
      request.get('/user/logout/' + this.user.id).then(() => {
        sessionStorage.clear()
        this.$router.push('/login');
      })
      // resetRouter()  //重置路由
    }
  },
  computed: {
    // 当前时间
    newTime: function () {
      return this.year + '年' + this.month + '月' + this.date + '日 星期' + this.day + ' ' + this.time;
    }
  },
  beforeDestroy() {
    clearInterval(interval);
  }
}
</script>
<style scoped>
.titleName {
  font-size: 20px;
  font-weight: bold;
  color: dodgerblue;
}

</style>