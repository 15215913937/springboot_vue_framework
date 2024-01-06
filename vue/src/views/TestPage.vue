<template>
  <div>
    <el-scrollbar style="height: 500px;width: 800px;">
      <el-row style="border: 1px solid red;display: flex">
        <el-col :span="6" style="display:flex;border: 1px black solid;justify-content: center;padding: 10px"
                v-for="item in items">
          <div class="grid-content ep-bg-purple" style="background-color: #409EFF;width: 100%;height: 300px">{{ item.a }}</div>
        </el-col>
      </el-row>
    </el-scrollbar>
  </div>
</template>
<script> export default {
  data() {
    return {
      items: [
        {"a": "b"}, {"a": "c"}, {"a": "d"}, {"a": "e"}, {"a": "f"},
        {"a": "g"}, {"a": "h"}, {"a": "g"}, {"a": "h"}, {"a": "g"},
        {"a": "h"}]
    };
  },
}; </script>