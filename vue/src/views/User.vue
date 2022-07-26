<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">
        <el-icon>
          <CirclePlus/>
        </el-icon>
        &nbsp新增
      </el-button>
    </div>
    <!--    搜索区-->
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="name" placeholder="请输入姓名" style="width: 20%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
      <!--            <el-button type="danger" style="float: right;margin-right: 10px">-->
      <!--                <el-icon>-->
      <!--                    <Delete/>-->
      <!--                </el-icon>-->
      <!--                &nbsp批量删除-->
      <!--            </el-button>-->

    </div>
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        style="width: 100%"
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" width="70px"/>
      <el-table-column prop="username" label="用户名"/>
      <el-table-column prop="role" label="角色">
        <template #default="scope">
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_ADMIN'">管理员</el-tag>
          <el-tag type="warning" v-if="scope.row.role === 'ROLE_USER'">普通用户</el-tag>
          <el-tag type="success" v-if="scope.row.role === 'ROLE_VISITOR'">游客</el-tag>
          <el-tag type="error" v-if="scope.row.role === 'ROLE_TESTER'">测试用户</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="姓名"/>
      <el-table-column prop="birthday" label="出生日期"/>
      <el-table-column prop="sex" label="性别" width="70px"/>

      <el-table-column fixed="right" label="操作" width="400px">
        <template #default="scope">
          <!--                  后端也要有个bookList属性-->
          <el-button plain type="success" @click="showBooks(scope.row.bookList)">查看图书列表
          </el-button>
          <el-button plain type="primary" @click="handleEdit(scope.row)" v-if="user.role==='ROLE_ADMIN'">编辑
          </el-button>
          <el-button plain type="primary" @click="resetPwd(scope.row)" v-if="user.role==='ROLE_ADMIN'">重置密码</el-button>
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button type="danger" v-if="user.role==='ROLE_ADMIN'">
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

      <el-dialog title="拥有图书列表" v-model="bookVis" width="30%">
        <el-table :data="bookList" stripe border>
          <el-table-column prop="id" label="ID"></el-table-column>
          <el-table-column prop="bookname" label="名称"></el-table-column>
          <el-table-column prop="author" label="作者"></el-table-column>
          <el-table-column prop="price" label="价格"></el-table-column>
          <el-table-column prop="buyDate" label="购买日期"></el-table-column>
        </el-table>
      </el-dialog>

      <!--      重置密码弹窗-->
      <el-dialog title="重置密码" v-model="pwdVis" width="30%">
        <el-form model="form" label-width="120px">
          <el-form-item label="新密码" prop="newPassword">
            <el-input v-model="form.newPassword" style="width: 80%" placeholder="默认123456"/>
          </el-form-item>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="pwdVis = false">取消</el-button>
                        <el-button type="primary" @click="saveNewPwd" :loading="loading">提交</el-button>
                    </span>
        </template>
      </el-dialog>

      <el-dialog v-model="dialogVisible" title="家庭成员信息" width="30%">
        <el-form model="form" label-width="120px">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="form.username" style="width: 80%" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="角色" prop="role">
            <el-select v-model="form.role" clearable placeholder="请选择角色" style="width: 80%">
              <el-option
                  v-for="item in roles"
                  :key="item.role"
                  :label="item.role"
                  :value="item.flag"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="姓名" prop="name" autocomplete="off">
            <el-input v-model="form.name" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="出生日期" prop="birthday">
            <el-date-picker
                v-model="form.birthday"
                type="date"
                clearable
                style="width: 80%"
                format="YYYY/MM/DD"
                value-format="YYYY-MM-DD"
            />
          </el-form-item>
          <el-form-item label="性别" prop="sex">
            <el-radio v-model="form.sex" label="男" size="large">男</el-radio>
            <el-radio v-model="form.sex" label="女" size="large">女</el-radio>
          </el-form-item>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save" :loading="loading">提交</el-button>
                    </span>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>

import request from "../utils/request";
import {Search, Delete} from "@element-plus/icons-vue";

export default {
  name: 'User',
  components: {},
  data() {
    return {
      loading: true,
      form: {},
      dialogVisible: false,
      bookVis: false,
      name: '',
      currentPage: 1,
      pageSize: 10,
      total: '',
      tableData: [],
      bookList: [],
      roles: [],
      pwdVis: false,
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
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
    showBooks(books) {
      this.bookList = books;
      this.bookVis = true
    },
    load() {
      this.loading = true;
      request.get("/user", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          name: this.name
        }
      }).then(res => {
        // console.log(res.data.records);
        this.loading = false;
        this.tableData = res.data.records;
        this.total = res.data.total;
      });
      request.get("/role").then(res => {
        this.roles = res.data;
        // console.log(this.roles)
      })
    },
    reset() {
      this.name = '';
      this.load();
    },
    add() {
      this.dialogVisible = true;
      // 清空表单域，点击取消后，下次打开就是清空内容了
      this.form = {}
    },
    save() {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1000)
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
      // console.log(this.form)
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
    },
    resetPwd(row) {
      this.form = JSON.parse(JSON.stringify(row));
      // console.log(this.form)
      this.pwdVis = true;
    },
    saveNewPwd() {
      // console.log(this.form)
      request.post("/user/resetPwd", this.form).then(res => {
        if (res.code === '0') {
          this.$message.success("重置成功")
        } else {
          this.$message.error(res.msg)
        }
        this.load();//刷新表格数据
        this.pwdVis = false
      })
    }
  }
}
</script>
