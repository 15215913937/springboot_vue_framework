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
      <el-button class="mb-10" type="danger" style="float: right;margin-right: 10px">
        <el-icon>
          <Delete/>
        </el-icon>
        &nbsp批量删除
      </el-button>

    </div>
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table :data="tableData" border stripe style="width: 100%" @selection-change="handleSelectionChange"
              highlight-current-row>
      <el-table-column type="selection" width="40px"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable=""/>
      <el-table-column label="封面">
        <template #default="scope">
          <el-image
              style="width: 100%; height: 90px"
              :src="scope.row.cover"
              :preview-src-list="[scope.row.cover]"
              hide-on-click-modal="true"
              preview-teleported="true">
          </el-image>
        </template>
      </el-table-column>
      <el-table-column prop="bookname" label="书名"/>
      <el-table-column prop="author" label="作者"/>
      <el-table-column prop="category" label="类别"/>
      <el-table-column prop="version" label="版本"/>
      <el-table-column prop="publishingHouse" label="出版社"/>
      <el-table-column prop="purchaser" label="购买人"/>
      <el-table-column prop="price" label="价格"/>
      <el-table-column prop="buyDate" label="购书日期"/>
      <el-table-column prop="comment" label="备注"/>
      <el-table-column fixed="right" label="操作" width="150px">
        <template #default="scope">
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
      <el-dialog v-model="dialogVisible" title="新增图书" width="30%">
        <el-form model="form" label-width="120px">
          <el-form-item label="封面">
            <el-upload ref="upload" :action="filesUploadUrl"
                       :on-success="fileUploadSuccess">
              <el-button type="primary">点击上传</el-button>
            </el-upload>
            <div slot="tip" style="font-size: 13px">只能上传jpg/png文件，且不超过1M</div>
          </el-form-item>
          <el-form-item label="书名">
            <el-input v-model="form.bookname" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="作者">
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
          <el-form-item label="购买人">
            <el-input v-model="form.purchaser" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="价格">
            <el-input v-model="form.price" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="购书日期">
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
            <el-input v-model="form.comment" style="width: 80%"/>
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
import {Search, Delete} from "@element-plus/icons-vue";

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
      filesUploadUrl: 'http://localhost:9090/files/upload'
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    //console.log(userStr)
    this.user = JSON.parse(userStr)
    // 请求服务端，确认当前登录用户的 合法信息
    request.get("/user/" + this.user.id).then(res => {
      if (res.code === '0') {
        this.user = res.data
      }
    })
    this.load();
  },
  setup() {
    return {
      Search, Delete
    }
  },
  methods: {
    fileUploadSuccess(res) {
      // console.log(res)
      this.form.cover = res.data
    },
    reset() {
      request.get("/book", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          name: '',
          author: '',
          category: ''
        }
      }).then(res => {
        // console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
        this.name = '';
        this.author = '';
        this.category = '';
      })
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
    },
    add() {
      this.dialogVisible = true;
      // 清空表单域，点击取消后，下次打开就是清空内容了
      this.form = {}
      this.$nextTick(() => {
        if (this.$refs['upload']) {
          this.$refs['upload'].clearFiles() //清楚历史文件列表
        }
      })
    },
    save() {
      if (this.form.id) {//若果id存在，更新
        request.put("/book", this.form).then(res => {
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
        request.post("/book", this.form).then(res => {
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
      this.$nextTick(() => {
        if (this.$refs['upload']) {
          this.$refs['upload'].clearFiles() //清楚历史文件列表
        }
      })
    },
    handleDelete(row) {
      this.id = row.id
      // console.log(this.id);
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
    // handleSelectionChange(val) {
    //   this.multipleSelection.forEach((item)=>{
    //     this.ids.push(item.id);
    //     console.log(this.ids)
    //   })
    // }
  }
}
</script>
