<template>
  <div class="main-header">
    <div style="margin: 10px 0">
      <el-button type="primary" @click="addTester">
        <el-icon>
          <Plus/>
        </el-icon>
        &nbsp新增测试者
      </el-button>
    </div>
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="search.name" placeholder="姓名" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
      <el-popconfirm title="你确定要删除吗" @confirm="deleteBatch">
        <template #reference>
          <el-button type="danger" style="float: right;margin-right: 10px" v-if="user.role===1">
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
        :data="form"
        border
        stripe
        style="width: 100%"
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="name" label="姓名" align="center"/>
      <el-table-column prop="height" label="身高(厘米)" align="center"/>
      <el-table-column prop="weight" label="体重（斤）" align="center"/>
      <el-table-column prop="sex" label="性别" align="center">
        <template #default="scope">
          <el-tag v-if="scope.row.sex === 1">男</el-tag>
          <el-tag v-if="scope.row.sex === 2" type="danger">女</el-tag>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template v-slot="scope">
          <el-button type="primary" @click="edit(scope.row)">编辑</el-button>
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
          v-model:currentPage=search.pageNum
          v-model:page-size=search.pageSize
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="search.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <el-dialog append-to-body v-model="editDialogVisible" title="编辑" width="500px">
        <el-form :model="userInfo" :rules="rules" ref="data" style="width: 250px" label-width="120px">
          <div style="display:flex;flex-direction: column;flex-wrap:wrap;justify-content: center">
            <el-form-item label="姓名" prop="name">
              <el-input v-model="userInfo.name"/>
            </el-form-item>
            <el-form-item label="身高(厘米)" prop="height">
              <el-input-number v-model="userInfo.height" min="0" max="500" :precision="2"/>
            </el-form-item>
            <el-form-item label="体重(斤)" prop="weight">
              <el-input-number v-model="userInfo.weight" min="1" max="2000" :precision="2"/>
            </el-form-item>
            <el-form-item label="性别" prop="sex">
              <el-radio-group v-model="userInfo.sex">
                <el-radio :label="1">男</el-radio>
                <el-radio :label="2">女</el-radio>
              </el-radio-group>
            </el-form-item>
          </div>

        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button type="primary" @click="submit" :loading="loading">提交</el-button>
          </span>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";

export default {
  name: "TestMemberManage",
  data() {
    return {
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      userInfo: {},
      loading: false,
      search: {
        name: '',
        pageNum: 1,
        pageSize: 10,
        total: '',
      },
      form: [],
      ids: [],
      editDialogVisible: false,
      rules: {
        name: [
          {required: true, message: '姓名未填', trigger: 'blur'}
        ],
        weight: [
          {required: true, message: '体重未填', trigger: 'blur'}
        ],
        height: [
          {required: true, message: '身高未填', trigger: 'blur'}
        ],
        sex: [
          {required: true, message: '性别未填', trigger: 'blur'}
        ],
      },
    }
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      request.get("/user-info", {
        params: {
          name: this.search.name,
        }
      }).then(res => {
        console.log(res)
        this.form = res.data.records;
        this.search.total = res.data.total;
      })
    },
    reset() {
      this.search = {
        name: '',
        pageNum: 1,
        pageSize: 10,
        total: '',
      }
      this.load();
    },
    addTester() {
      this.editDialogVisible = true
      this.userInfo = {}
    },
    edit(row) {
      this.editDialogVisible = true
      this.userInfo = JSON.parse(JSON.stringify(row))
    },
    submit() {
      this.$refs.data.validate(valid => {
        if (valid) {
          request.post("/user-info", this.userInfo).then(res => {
                if (res.code === '0') {
                  this.$message.success("提交成功")
                } else {
                  this.$message.error("提交失败")
                }
                this.editDialogVisible = false
                this.loading = false
                this.userInfo = {}
                this.load()
              }
          )
        }
      })
    },
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的测试人员");
        return
      }
      request.post("/user-info/deleteBatch", this.ids).then(res => {
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
    handleDelete(row) {
      request.delete("/user-info/" + row.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功");
          this.load();
        } else {
          this.$message.error(res.msg)
        }
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