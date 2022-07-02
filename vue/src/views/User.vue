<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add"><el-icon><CirclePlus /></el-icon>&nbsp新增</el-button>
    </div>
    <!--    搜索区-->
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="name" placeholder="请输入姓名" style="width: 20%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button type="danger" style="float: right;margin-right: 10px"><el-icon><Delete /></el-icon>&nbsp批量删除</el-button>

    </div>
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table :data="tableData" border stripe style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable=""/>
      <el-table-column prop="username" label="用户名"/>
      <el-table-column prop="name" label="姓名"/>
      <el-table-column prop="birthday" label="出生日期"/>
      <el-table-column prop="sex" label="性别"/>
      <el-table-column label="相册">
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="150px">
        <template #default="scope">
          <el-button link type="primary" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button type="danger">删除
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
          :page-sizes="[5, 10, 50]"
          :small="small"
          :disabled="disabled"
          :background="background"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <el-dialog v-model="dialogVisible" title="新增家庭成员" width="30%">
        <el-form model="form" label-width="120px">
          <el-form-item label="用户名">
            <el-input v-model="form.username" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="姓名">
            <el-input v-model="form.name" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="出生日期">
            <el-date-picker
                    v-model="form.birthday"
                    type="date"
                    clearable
                    style="width: 80%"
                    format="YYYY/MM/DD"
                    value-format="YYYY-MM-DD"
            />
          </el-form-item>
          <el-form-item label="性别">
            <el-radio v-model="form.sex" label="男" size="large">男</el-radio>
            <el-radio v-model="form.sex" label="女" size="large">女</el-radio>
          </el-form-item>
          <el-form-item label="相册">
          </el-form-item>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save">提交</el-button>
                    </span>
        </template>
      </el-dialog>
    </div>

  </div>
</template>

<script>

import request from "../utils/request";
import {Search,Delete} from "@element-plus/icons-vue";

export default {
  name: 'User',
  components: {},
  data() {
    return {
      form: {},
      dialogVisible: false,
      name: '',
      currentPage: 1,
      pageSize: 5,
      total: 5,
      tableData: []
    }
  },
  created() {
    this.load();
  },
  setup() {
    return {
      Search,
      Delete
    }
  },
  methods: {
    load() {
      request.get("/user", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          name: this.name
        }
      }).then(res => {
        // console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },
    add() {
      this.dialogVisible = true;
      // 清空表单域，点击取消后，下次打开就是清空内容了
      this.form = {}
    },
    save() {
      if (this.form.id) {//若果id存在，更新
        request.put("/user", this.form).then(res => {
          // console.log(res);
          if (res.code === '0') {
            this.$message.success("修改成功")
          } else {
            this.$message.error(res.msg)
          }
          this.load();//刷新表格数据
          this.dialogVisible = false
        });
      } else {//如果id不存在，新增
        request.post("/user", this.form).then(res => {
          // console.log(res);
          if (res.code === '0') {
            this.$message.success("新增成功")
          } else {
            this.$message.error(res.msg)
          }
          this.load();//刷新表格数据
          this.dialogVisible = false
        });
      }
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.id = row.id
      // console.log(this.id);
      request.delete("/user/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
        this.load();//刷新表格数据
      })
    },
    handleSizeChange() {
      //改变当前每页个数的触发
      this.load()
    },
    handleCurrentChange() {
      //改变当前页数的触发
      this.load()
    }
  }
}
</script>
