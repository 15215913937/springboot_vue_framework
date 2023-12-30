<template>
  <div>
    <div style="position: fixed; top: 0; width: 100%;z-index: 9999;left: 0">
      <Header :user="user"/>
    </div>
    <div style="position: fixed;left: 0;top: 50px;width: 180px;z-index: 9999">
      <Aside/>
    </div>
    <div style="margin: 50px 0 0 180px">
      <router-view @refreshUser="refreshUser"/>
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
.header {
  height: 50px;
  background-color: #ccc;
}

.sidebar {
  height: calc(100vh - 50px);
  background-color: #ddd;
}

.content {
  height: 1000px;
  background-color: #eee;
}
</style>
