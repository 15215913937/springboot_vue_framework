<template>
  <div>
    <!--    头部-->
      <Header :user="user"/>

    <!--    主体-->
    <div style="display: flex">
      <!--      侧边栏-->
<!--      <div style="width:180px;position:fixed;left:0;top: 50px">-->
        <Aside/>

        <router-view style="flex: 1" @refreshUser="refreshUser"/>

      <!--      内容区域-->
      <!--          当前页面的子路由会在router-view中展示-->

    </div>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Aside from "@/components/Aside";
import request from "@/utils/request";

export default {
  name: "Layout",
  components: {
    Header,
    Aside
  },
  data() {
    return {
      user: {},
    }
  },
  created() {
    // 一开始就从后台获取user最新数据
    this.refreshUser()
  },
  methods: {
    refreshUser() {
      let userJson = sessionStorage.getItem("user");
      if (!userJson) {
        return
      }
      let userId = JSON.parse(userJson).id;
      // 从后台取出更新后的用户信息
      request.get("/user/" + userId).then(res => {
        // 重新赋值后台的最新数据
        this.user = res.data;
      })
    }
  }
}
</script>

<style scoped>

</style>
