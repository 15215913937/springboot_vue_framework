<template>
  <div>
    <div style="display:flex;height:60px;line-height: 50px;border-bottom: 1px solid #5B6568FF">
      <div class="titleName">
        沈 居
      </div>
      <div style="flex: 1">
        <el-menu
            :default-active="1"
            class="el-menu-demo"
            mode="horizontal"
            @select="handleSelect"
            router
        >
          <el-sub-menu index="1">
            <template #title>菜单一</template>
            <el-menu-item index="/user">item one</el-menu-item>
            <el-menu-item index="2-2">item two</el-menu-item>
            <el-menu-item index="2-3">item three</el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="2">
            <template #title>菜单二</template>
            <el-menu-item index="2-1">item one</el-menu-item>
            <el-menu-item index="2-2">item two</el-menu-item>
            <el-menu-item index="2-3">item three</el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="3">
            <template #title>菜单三</template>
            <el-menu-item index="2-1">item one</el-menu-item>
            <el-menu-item index="2-2">item two</el-menu-item>
            <el-menu-item index="2-3">item three</el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="4">
            <template #title>菜单四</template>
            <el-menu-item index="2-1">item one</el-menu-item>
            <el-menu-item index="2-2">item two</el-menu-item>
            <el-menu-item index="2-3">item three</el-menu-item>
          </el-sub-menu>
        </el-menu>
      </div>
      <div style="width: 150px">
        <div v-if="!this.user">
          <el-button>登录</el-button>
          <el-button>注册</el-button>
        </div>
        <div v-else style="display: flex;line-height: 60px">
          <div style="width: 40px;height: 60px">
            <img :src="this.user.avatar" alt=""
                 style="width: 30px; border-radius: 50%; text-align: center;margin: 15px auto">
          </div>
          <div style="flex: 1;height: 60px">
            <el-dropdown style="width: 100px;cursor: pointer;text-align: center">
              <span style="position: relative;padding-top: 21px">{{ this.user.username }}({{ this.user.name }})</span>
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

    </div>
    <router-view/>
  </div>

</template>

<script>
export default {
  name: "Front",
  data() {
    return {
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
    }
  }

}
</script>

<style scoped>
.item {
  width: 100px;
  display: inline-block;
  text-align: center;
  cursor: pointer
}

.item:hover {
  background-color: #A4B8CDFF;
}

.titleName {
  font-family: 华文楷体;
  font-size: 40px;
  color: deepskyblue;
  height: 60px;
  position: relative;
  margin: auto;
  width: 200px;
  text-align: center;
}
</style>