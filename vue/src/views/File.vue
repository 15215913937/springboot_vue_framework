<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0">
      <el-upload :action="'http://'+serverIp+':'+serverPort+'/files/testUpload'" :show-file-list="false"
                 :on-success="handleFileUploadSuccess" style="display: inline">
        <el-button type="primary">
          <el-icon>
            <CirclePlus/>
          </el-icon>
          &nbsp上传文件
        </el-button>
      </el-upload>
    </div>
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="name" placeholder="请输入文件名称" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="type" placeholder="请输入文件类型" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
      <el-popconfirm title="你确定要删除吗" @confirm="deleteBatch">
        <template #reference>
          <el-button type="danger" style="float: right;margin-right: 10px" v-if="user.role==='ROLE_ADMIN'">
            <el-icon>
              <Delete/>
            </el-icon>
            &nbsp批量删除
          </el-button>
        </template>
      </el-popconfirm>
    </div>

    <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        style="width: 100%"
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="name" label="文件名称" align="center"/>
      <el-table-column prop="type" label="类型" align="center"/>
      <el-table-column prop="size" label="文件大小（kb）" align="center"/>
      <el-table-column label="启用" align="center">
        <template v-slot="scope">
          <el-switch v-model="scope.row.enable" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeEnable(scope.row)"/>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template v-slot="scope">
          <el-button type="primary" @click="preview(scope.row.url)">预览</el-button>
          <el-button type="primary" @click="download(scope.row.url)">下载</el-button>
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button type="danger">
                <el-icon>
                  <Delete/>
                </el-icon>
              </el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
      <el-pagination small layout="prev, pager, next" :total="50"/>
    </el-table>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50]"
          :small="small"
          :disabled="disabled"
          :background="background"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script>
import request from "../utils/request";
import {Search} from "@element-plus/icons-vue";
import {serverIp, serverPort} from "../../public/config";

export default {
  name: "File",
  data() {
    return {
      name: '',
      type: '',
      currentPage: 1,
      pageSize: 10,
      total: 10,
      tableData: [],
      multipleSelection: [],
      serverIp: serverIp,
      serverPort: serverPort
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || {};
    // console.log(userStr)
    this.user = JSON.parse(userStr);
    // 请求服务端，确认当前登录用户的 合法信息
    request.get("/user/" + this.user.id).then(res => {
      if (res.code === '0') {
        this.user = res.data
      }
    });
    this.load();
  },
  setup() {
    return {
      Search
    }
  },
  methods: {
    changeEnable(row) {
      request.post("/files/update", row).then(res => {
        if (res.code === '0') {
          this.load()
        }
      })
    },
    download(url) {
      window.open(url)
    },
    preview(url) {
      window.open('https://file.keking.cn/onlinePreview?url=' + encodeURIComponent(window.btoa((url))))
    },
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除文件");
        return
      }
      request.post("/files/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功");
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => v.id)
    },
    fileUploadSuccess(res) {
      // console.log(res)
      this.form.cover = res.data
    },
    reset() {
      this.name = '';
      this.type = '';
      this.load();
    },
    load() {
      request.get("/files", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          name: this.name,
          type: this.type
        }
      }).then(res => {
        // console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/files/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
          this.load();//刷新表格数据
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleSizeChange() {
      //改变当前每页个数的触发
      this.load()
    },
    handleCurrentChange() {
      //改变当前页数的触发
      this.load()
    },
    handleFileUploadSuccess(res) {
      // console.log(res)
      this.load()
    }
  }
}
</script>

<style scoped>

</style>