<template>
  <div class="main-header">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">
        <el-icon>
          <CirclePlus/>
        </el-icon>
        &nbsp新增
      </el-button>
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        :header-cell-style="{'text-align':'center'}"
        border
        stripe
        style="width: 100%">
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="role" label="角色" align="center"/>
      <el-table-column prop="flag" label="唯一标识" align="center"/>
      <el-table-column prop="description" label="描述"/>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template #default="scope">
          <el-button plain type="success" @click="selectMenu(scope.row.id)">
            <el-icon>
              <Menu/>
            </el-icon>
            分配菜单
          </el-button>
          <el-button plain type="primary" @click="handleEdit(scope.row)">编辑</el-button>
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
    </el-table>
    <div style="margin: 10px 0">
      <el-dialog v-model="menuDialogVis" title="菜单分配" width="30%">
        <el-tree
            :props="props"
            :data="menuData"
            node-key="id"
            ref="tree"
            :default-expanded-keys="expends"
            :default-checked-keys="checks"
            show-checkbox
        />
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="menuDialogVis = false">取消</el-button>
                        <el-button type="primary" @click="saveRoleMenu()" :loading="loading">提交</el-button>
                    </span>
        </template>
      </el-dialog>
      <el-dialog v-model="dialogVisible" title="角色信息" width="30%">
        <el-form :model="roles" label-width="120px" ref="pass" :rules="rules">
          <el-form-item label="角色" prop="role">
            <el-input v-model="roles.role" show-word-limit maxlength="20" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="唯一标识" prop="flag">
            <el-input v-model="roles.flag" show-word-limit maxlength="20" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="描述">
            <el-input type="textarea" show-word-limit maxlength="100" v-model="roles.description" style="width: 80%"/>
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
  name: 'Role',
  components: {},
  data() {
    return {
      loading: false,
      form: {},
      menuDialogVis: false,
      dialogVisible: false,
      role: '',
      roles: {},
      tableData: [],
      menuData: [],
      props: {
        label: 'name',
      },
      roleId: 0,
      expends: [],
      checks: [],
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      rules: {
        role: [
          {required: true, message: '角色名称不能为空', trigger: 'blur'},
          {min: 2, max: 20, message: '长度在2~20位之间', trigger: 'blur'},
        ],
        flag: [
          {required: true, message: '角色标志不能为空', trigger: 'blur'},
          {min: 3, max: 20, message: '长度在3~20位之间', trigger: 'blur'},
        ],
      }
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
      this.loading = true;
      request.get("/role/allRole").then(res => {
        this.loading = false;
        this.tableData = res.data;
      });
    },
    reset() {
      this.role = '';
      this.load();
    },
    add() {
      this.dialogVisible = true;
      // 清空表单域，点击取消后，下次打开就是清空内容了
      this.roles = {}
    },
    save() {
      this.$refs.pass.validate((valid) => {
        if (valid) {
          //提交加载效果设置，放置点击太快重复提交
          this.loading = true
          setTimeout(() => {
            this.loading = false
          }, 1000)
          request.post("/role", this.roles).then(res => {
            // console.log(res);
            if (res.code === '0') {
              this.$message.success("修改成功")
              this.load();//刷新表格数据
              this.dialogVisible = false
            } else {
              this.$message.error(res.msg)
            }
          });
        }
      })
    },
    saveRoleMenu() {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1000)
      request.post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys()).then(res => {
        if (res.code === '0') {
          this.menuDialogVis = false;
          this.$message.success("分配成功");
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleEdit(row) {
      this.roles = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.id = row.id
      request.delete("/role/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
        this.load();
      })
    },
    selectMenu(roleId) {
      this.roleId = roleId;
      this.menuDialogVis = true;
      request.get("/role/roleMenu/" + roleId).then(res => {
        this.checks = res.data;
      })
      request.get("/menu").then(res => {
        this.menuData = res.data;
        // 把后台返回的菜单数据处理成id数组
        this.expends = this.menuData.map(v => v.id)
      })
    }
  }
}
</script>
