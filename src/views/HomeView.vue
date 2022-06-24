<!-- 引入HelloWorld.vue组件-->

<template>
  <div style="padding: 10px">
<!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary">新增</el-button>
    </div>
<!--    搜索区-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%"/>
      <el-button type="primary" style="margin-left: 20px">查询</el-button>
    </div>
<!--    列表区-->
    <el-table :data="tableData" border stripe style="width: 100%">
      <el-table-column prop="date" label="日期" sortable=""/>
      <el-table-column prop="name" label="姓名"/>
      <el-table-column prop="address" label="地址"/>
    </el-table>
  </div>
</template>

<script>

export default {
  name: 'HomeView',
  //定义一个HelloWorld组件
  components: {},
  data() {
    return {
      search: '',
      tableData: [
        {
          date: '2016-05-03',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-02',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-04',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-01',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
      ]
    }
  }
}
</script>
