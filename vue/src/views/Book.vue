<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add" v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
        <el-icon>
          <CirclePlus/>
        </el-icon>
        &nbsp新增
      </el-button>
      <el-button type="success" @click="exportbooks">
        <el-icon>
          <Upload/>
        </el-icon>
        &nbsp导出
      </el-button>
    </div>
    <!--    搜索区-->
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="name" placeholder="请输入书名" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="author" placeholder="请输入作者" style="width: 15%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <el-input v-model="category" placeholder="请输入类别" style="width: 15%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <!--            <el-input v-model="buyDate" placeholder="请输入时间" style="width: 15%" :prefix-icon="Search" class="mr-10"-->
      <!--                      clearable/>-->
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
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table
        :data="tableData"
        border
        stripe
        style="width: 100%"
        @selection-change="handleSelectionChange"
        highlight-current-row>
      <el-table-column type="selection" align="center"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column label="封面" align="center">
        <template #default="scope">
          <el-image
              style="width: 100%; height: 90px"
              :header-cell-style="{'text-align':'center'}"
              :src="scope.row.cover"
              :preview-src-list="[scope.row.cover]"
              hide-on-click-modal="true"
              preview-teleported="true">
          </el-image>
        </template>
      </el-table-column>
      <el-table-column prop="bookname" label="书名" align="center"/>
      <el-table-column prop="author" label="作者" align="center"/>
      <el-table-column prop="category" label="类别" align="center"/>
      <el-table-column prop="version" label="版本" align="center"/>
      <el-table-column prop="publishingHouse" label="出版社" align="center"/>
      <el-table-column prop="username" label="购买人" align="center"/>
      <el-table-column prop="price" label="价格" align="center"/>
      <el-table-column prop="buyDate" label="购书日期" align="center"/>
      <el-table-column prop="comment" label="备注"/>
      <el-table-column fixed="right" label="操作" width="150px" align="center">
        <template #default="scope">
          <el-button plain type="primary" @click="handleEdit(scope.row)"
                     v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
            编辑
          </el-button>
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

      <el-dialog v-model="dialogVisible" title="书籍信息" width="30%">
        <el-form :model="form" label-width="120px" ref="pass" :rules="rules">
          <el-form-item label="封面">
            <el-upload ref="upload" :action="filesUploadUrl"
                       :on-success="fileUploadSuccess">
              <el-button type="primary">点击上传</el-button>
            </el-upload>
            <div slot="tip" style="font-size: 13px">只能上传jpg/png文件，且不超过1M</div>
          </el-form-item>
          <el-form-item label="书名" prop="bookname">
            <el-input v-model="form.bookname" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="作者" prop="author">
            <el-input v-model="form.author" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="类别">
            <el-input v-model="form.category" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="版本">
            <el-input v-model="form.version" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="出版社">
            <el-input v-model="form.publishingHouse" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="购买人" prop="uid">
            <el-select v-model="form.uid" clearable placeholder="选择购买人" style="width: 80%">
              <el-option v-for="item in users" :key="item.id" :label="item.name"
                         :value="item.id"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="价格" prop="price">
            <el-input v-model.number="form.price" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="购书日期" prop="buyDate">
            <el-date-picker
                v-model="form.buyDate"
                type="date"
                clearable
                style="width: 80%"
                format="YYYY/MM/DD"
                value-format="YYYY-MM-DD"
            />
          </el-form-item>
          <el-form-item label="备注">
            <el-input type="textarea" v-model="form.comment" style="width: 80%"/>
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
import {Search, Delete, Upload} from "@element-plus/icons-vue";
import {serverIp} from "../../public/config";

export default {
  name: 'Book',
  components: {},
  data() {
    return {
      form: {},
      dialogVisible: false,
      name: '',
      author: '',
      category: '',
      currentPage: 1,
      pageSize: 10,
      total: 10,
      tableData: [],
      multipleSelection: [],
      ids: [],
      filesUploadUrl: 'http://' + serverIp + ':9090/files/upload',
      users: [],
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      rules: {
        bookname: [
          {required: true, message: '书名不能为空', trigger: 'blur'},
          {min: 1, max: 30, message: '长度在1~30位之间', trigger: 'blur'},
        ],
        author: [
          {required: true, message: '作者不能为空', trigger: 'blur'},
          {min: 1, max: 30, message: '长度在1~30位之间', trigger: 'blur'},
        ],
        price: [
          {required: true, message: '价格不能为空', trigger: 'blur'},
          { type: 'number', message: '只能输入整数' },
        ],
        uid: [
          {required: true, message: '未选择购买人', trigger: 'blur'},
        ]
      }
    }
  },
  created() {
    this.load();
    // console.log(this.user)
  },
  setup() {
    return {
      Search,
      Delete,
      Upload
    }
  },
  methods: {
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的书籍");
        return
      }
      request.post("/book/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功")
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
      this.author = '';
      this.category = '';
      this.load();
    },
    load() {
      request.get("/book", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          name: this.name,
          author: this.author,
          category: this.category
        }
      }).then(res => {
        // console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
      request.get("/user/all").then(res => {
        this.users = res.data;
      })
    },
    add() {
      this.dialogVisible = true;
      // 清空表单域，点击取消后，下次打开就是清空内容了
      this.form = {}
      this.$nextTick(() => {
        if (this.$refs['upload']) {
          this.$refs['upload'].clearFiles() //清除历史文件列表
        }
      })

    },
    save() {
      this.$refs.pass.validate((valid)=>{
        if(valid){
          this.loading = true
          setTimeout(() => {
            this.loading = false
          }, 1000)
          request.post("/book", this.form).then(res => {
            // console.log(res);
            if (res.code === '0') {
              this.$message.success("操作成功")
            } else {
              this.$message.error(res.msg)
            }
            this.load();//刷新表格数据
            this.dialogVisible = false
          });
        }
      })

    },
    handleEdit(row) {
      // console.log(row)
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
      this.$nextTick(() => {
        if (this.$refs['upload']) {
          this.$refs['upload'].clearFiles() //清除历史文件列表
        }
      })
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/book/" + this.id).then(res => {
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
    exportbooks() {
      window.open('http://' + serverIp + ':9090/book/export')
    }
  }
}
</script>
