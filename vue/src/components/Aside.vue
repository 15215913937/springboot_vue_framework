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
      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <SetUp/>
          </el-icon>
          <span>事务管理</span>
        </template>
        <el-menu-item index="/index/book">
          <el-icon>
            <Notebook/>
          </el-icon>
          书籍管理
        </el-menu-item>
        <el-menu-item index="/index/events">
          <el-icon>
            <Ship/>
          </el-icon>
          事件论坛
        </el-menu-item>
      </el-sub-menu>
      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <Setting/>
          </el-icon>
          <span>系统管理</span>
        </template>
        <el-menu-item index="/index/user">
          <el-icon>
            <UserFilled/>
          </el-icon>
          成员管理
        </el-menu-item>
      </el-sub-menu>

    </el-menu>
  </div>
</template>

<script>

export default {
  name: "Aside",
  data() {
    return {
      path: this.$route.path  //设置菜单按钮默认高亮效果
    }
  }
}
</script>
