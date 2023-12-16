<template>
  <div style="padding: 10px">

    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="search.code" placeholder="请输入传感垫key" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="search.bedId" placeholder="请输入采集床垫ID" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="search.mat" placeholder="选择舒适层" style="width: 15%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <el-input v-model="search.batch" placeholder="选择批次" style="width: 15%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <el-input v-model="search.coefficient" placeholder="选择数据系数" style="width: 15%" :prefix-icon="Search"
                class="mr-10"
                clearable/>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
      <el-popconfirm title="确定要删除吗" @confirm="deleteBatch">
        <template #reference>
          <el-button class="mb-10" type="danger" style="float: right;margin-right: 10px"
                     v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
            <el-icon>
              <Delete/>
            </el-icon>
            &nbsp批量删除
          </el-button>
        </template>
      </el-popconfirm>

    </div>
    <el-table
        :data="tableData"
        border
        stripe
        style="width: 100%"
        highlight-current-row>

      <el-table-column type="selection" align="center"/>
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="code" label="传感垫key" align="center"/>
      <el-table-column prop="bedId" label="采集床垫" align="center"/>
      <el-table-column prop="mat" label="舒适层" align="center"/>
      <el-table-column prop="batch" label="批次" align="center"/>
      <el-table-column prop="firstPressure" label="首次压力和" align="center"/>
      <el-table-column prop="finalPressure" label="最终压力和" align="center"/>
      <el-table-column prop="coefficient" label="系数" align="center"/>

      <el-table-column fixed="right" label="操作" width="150px" align="center">
        <template #default="scope">
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button type="danger" v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
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
          v-model:currentPage="page.currentPage"
          v-model:page-size="page.pageSize"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="page.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script>
import request from "../utils/request";
import {Search, Delete, Upload} from "@element-plus/icons-vue";

export default {
  name: "DataAcquisition",
  data() {
    return {
      search: {
        code: '',
        bedId: '',
        mat: '',
        batch: '',
        coefficient: ''
      },
      tableData: [],
      page: {
        currentPage: 1,
        pageSize: 10,
        total: '',
      },
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load();
  },
  setup() {
    return {
      Search,
      Delete,
      Upload
    }
  },
  methods: {
    load() {
      request.get("/renhe-collect", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          code: this.code,
          bedId: this.bedId,
          mat: this.mat,
          batch: this.batch,
          coefficient: this.coefficient
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.total = res.data.total;
      });
    },
    reset() {
      this.code = '';
      this.bedId = '';
      this.mat = '';
      this.batch = '';
      this.coefficient = '';
      this.load();
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/renhe-collect/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的数据");
        return
      }
      request.post("/renhe-collect/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功");
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    handleSizeChange() {
      this.load()
    },
    handleCurrentChange() {
      this.load()
    }
  }
}
</script>

<style scoped>

</style>