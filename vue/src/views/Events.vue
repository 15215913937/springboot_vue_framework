<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">
        <el-icon>
          <CirclePlus/>
        </el-icon>
        &nbsp发表新事件
      </el-button>
    </div>
    <!--    搜索区-->
    <div style="margin: 10px 0;display: block;clear: both">
      <el-input v-model="title" placeholder="请输入标题" style="width: 20%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="author" placeholder="请输入作者" style="width: 20%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <!--      <el-input v-model="createTime" placeholder="请选择时间" style="width: 20%" :prefix-icon="Search" class="mr-10"-->
      <!--                clearable/>-->
      <!--      <el-date-picker-->
      <!--          class="mr-10"-->
      <!--          v-model="createTime"-->
      <!--          type="daterange"-->
      <!--          unlink-panels-->
      <!--          range-separator="-"-->
      <!--          start-placeholder="开始日期"-->
      <!--          end-placeholder="结束日期"-->
      <!--          :shortcuts="shortcuts"-->
      <!--          :size="size"-->
      <!--      />-->
      <el-button type="primary" class="mb-10" @click="load">查询</el-button>
      <el-button type="primary" class="mb-10" @click="reset">重置</el-button>
      <el-button type="danger" style="float: right;margin-right: 10px">
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
      <el-table-column prop="title" label="标题"/>
      <el-table-column prop="author" label="作者"/>
      <el-table-column prop="createTime" label="创建时间"/>
      <el-table-column fixed="right" label="操作" width="300px">
        <template #default="scope">
          <el-button plain type="success" @click="details(scope.row)">详情</el-button>
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
      <el-dialog v-model="dialogVisible" title="编辑事件" width="50%">
        <el-form model="form" label-width="120px">
          <el-form-item label="标题">
            <el-input v-model="form.title" style="width: 50%"/>
          </el-form-item>
          <div id="div1">

          </div>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save">发布</el-button>
                    </span>
        </template>
      </el-dialog>
      <el-dialog v-model="vis" title="事件详情" width="50%">
        <el-card>
          <div v-html="detail.content" style="min-height: 100px"></div>
        </el-card>
      </el-dialog>
    </div>

  </div>
</template>

<script>

import request from "../utils/request";
import {Search, Delete} from "@element-plus/icons-vue";
import '@wangeditor/editor/dist/css/style.css' // 引入 css

import E from 'wangeditor'
//设置全局变量
let editor;
let userStr = sessionStorage.getItem("user") || "{}"
let user = JSON.parse(userStr)
// const shortcuts = [
//   {
//     text: 'Last week',
//     value: () => {
//       const end = new Date()
//       const start = new Date()
//       start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
//       return [start, end]
//     },
//   },
//   {
//     text: 'Last month',
//     value: () => {
//       const end = new Date()
//       const start = new Date()
//       start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
//       return [start, end]
//     },
//   },
//   {
//     text: 'Last 3 months',
//     value: () => {
//       const end = new Date()
//       const start = new Date()
//       start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
//       return [start, end]
//     },
//   },
// ]
export default {
  name: 'Events',
  components: {},
  data() {
    return {
      form: {},
      dialogVisible: false,
      title: '',
      author: '',
      // createTime: '',
      currentPage: 1,
      pageSize: 10,
      total: 10,
      tableData: [],
      detail: {},
      vis: false,
      editor: null
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
    details(row) {
      this.detail = row
      this.vis = true
    },
    reset() {
      request.get("/events", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          title: '',
          author: '',
          // createTime: ''
        }
      }).then(res => {
        // console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
        this.title = '';
        this.author = '';
      })
    },
    load() {
      request.get("/events", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          title: this.title,
          author: this.author,
          // createTime: this.createTime
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
      this.form = {};
      //缓冲效果，等待页面元素加载完成
      this.$nextTick(() => {
        if (!editor) {
          //关联add弹窗里面的div，new一个editor对象
          editor = new E('#div1');
          //本地图片上传设置注意后端设置返回json格式
          editor.config.uploadImgServer = 'http://localhost:9090/files/editor/upload'
          editor.config.uploadFileName = "file"
          editor.create()
        }
        editor.txt.html("")
      })

    },
    save() {
      this.form.content = editor.txt.html(); //获取编辑器里面的值。然后赋予到实体form对象当中

      if (this.form.id) {//若果id存在，更新
        let userStr = sessionStorage.getItem("user") || "{}"
        let user = JSON.parse(userStr)
        // console.log("原作者："+this.form.author+",新作者："+user.name)
        if (this.form.author === user.name) {
          request.put("/events", this.form).then(res => {
            // console.log(res);
            if (res.code === '0') {
              this.$message.success("编辑成功")
            } else {
              this.$message.error(res.msg)
            }
            this.load();//刷新表格数据
            this.dialogVisible = false
          });
        } else {
          this.$message.error("不是作者本人，编辑无效！")
        }

      } else {//如果id不存在，新增

        this.form.author = user.name
        request.post("/events", this.form).then(res => {
          // console.log(res);
          if (res.code === '0') {
            this.$message.success("发表成功")
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
        if (!editor) {
          editor = new E('#div1');
          editor.config.uploadImgServer = 'http://localhost:9090/files/editor/upload'
          editor.config.uploadFileName = "file"
          editor.create()
        }
        editor.txt.html(row.content)
      })
    },
    handleDelete(row) {

      this.id = row.id;
      // console.log(this.id);
      request.delete("/events/" + this.id).then(res => {
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
  }
}
</script>
