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
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table
        :header-cell-style="{'text-align':'center'}"
        v-loading="loading"
        :data="tableData"
        row-key="id"
        default-expand-all
        border
        stripe
        style="width: 100%">
      <el-table-column prop="id" label="ID" sortable="" align="center" width="100px"/>
      <el-table-column prop="name" label="菜单名称" align="center"/>
      <el-table-column prop="path" label="路径" align="center"/>
      <el-table-column prop="pagePath" label="页面路径" align="center"/>
      <el-table-column label="图标" align="center" class-name="fontSize12">
        <template #default="scope">
          <el-icon>
            <component :is="scope.row.icon"/>
          </el-icon>
        </template>
      </el-table-column>
      <!--            <el-table-column prop="icon" label="图标"/>-->
      <el-table-column prop="description" label="描述"/>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template #default="scope">
          <el-button plain type="success" @click="handleAdd(scope.row.id)"
                     v-if="!scope.row.pid && !scope.row.path">
            <el-icon>
              <Plus/>
            </el-icon>
            新增子菜单
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
      <el-dialog v-model="dialogVisible" title="菜单信息" width="30%">
        <el-form :model="form" label-width="120px" :rules="rules" ref="pass">
          <el-form-item label="上级菜单" prop="icon">
            <el-select v-model="form.pid" clearable placeholder="上级选择" style="width: 80%">
              <el-option
                  v-for="item in pids"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
              >
                <el-icon>
                  <component :is="item.id"></component>
                </el-icon>
                <span>{{ item.name }}</span>
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="菜单名称" prop="name">
            <el-input v-model="form.name" show-word-limit maxlength="20" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="路径" prop="path">
            <el-input v-model="form.path" show-word-limit maxlength="20" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="页面路径" prop="pagePath">
            <el-input v-model="form.pagePath" show-word-limit maxlength="20" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="图标" prop="icon">
            <el-select v-model="form.icon" clearable placeholder="选择图标" style="width: 80%">
              <el-option
                  v-for="item in options"
                  :key="item.name"
                  :label="item.name"
                  :value="item.value"
              >
                <el-icon>
                  <component :is="item.value"></component>
                </el-icon>
                <span>{{ item.name }}</span>
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input type="textarea" v-model="form.description" show-word-limit maxlength="100" style="width: 80%"/>
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
import User from "./User";

export default {
  name: 'Menu',
  components: {User},
  data() {
    return {
      loading: true,
      form: {},
      dialogVisible: false,
      tableData: [],
      options: [],
      pids: [],
      rules: {
        name: [
          {required: true, message: '菜单名称不能为空', trigger: 'blur'},
          {min: 2, max: 20, message: '长度在2~20位之间', trigger: 'blur'},
        ],
        pathPage: [
          {required: true, message: '菜单路径不能为空', trigger: 'blur'},
          {min: 3, max: 20, message: '长度在3~20位之间', trigger: 'blur'},
        ]
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
      request.get("/menu", {
        params: {
          name: this.name
        }
      }).then(res => {
        this.loading = false;
        this.tableData = res.data;
      })
    },
    add() {
      this.dialogVisible = true;
      this.form = {}
      this.pids=[]
      // 请求图标的数据
      request.get("/menu/icons").then(res => {
        this.options = res.data;
      })
      for (const re of this.tableData) {
        this.pids.push({"id": re.id, "name": re.name})
      }
    },
    save() {
      this.$refs.pass.validate((valid) => {
        if (valid) {
          this.loading = true;
          setTimeout(() => {
            this.loading = false
          }, 1000);
          request.post("/menu", this.form).then(res => {
            if (res.code === '0') {
              this.$message.success("修改成功");
              this.load();
              this.dialogVisible = false
            } else {
              this.$message.error(res.msg)
            }
          });
        }
      })
    },
    handleEdit(row) {
      this.pids=[]
      console.log(row)
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
      request.get("/menu/icons").then(res => {
        this.options = res.data;
      })
      for (const re of this.tableData) {
        if (re.id !== row.id) {
          this.pids.push({"id": re.id, "name": re.name})
        }
      }
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/menu/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
        this.load();//刷新表格数据
      })
    },
    handleAdd(pid) {
      this.dialogVisible = true
      this.form = {}
      if (pid) {
        this.form.pid = pid
      }
    }
  }
}
</script>
<style>
.fontSize12 {
  font-size: 20px;
}
</style>