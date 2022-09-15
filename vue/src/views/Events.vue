<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add" v-if="user.role ==='ROLE_ADMIN'|| user.role ==='ROLE_USER'">
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
      <el-date-picker
          class="mr-10"
          v-model="timeHorizon"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          unlink-panels
      />
      <el-button type="primary" class="mb-10" @click="load">查询</el-button>
      <el-button type="primary" class="mb-10" @click="reset">重置</el-button>
      <el-popconfirm title="确定要删除吗" @confirm="deleteBatch">
        <template #reference>
          <el-button class="mb-10" type="danger" style="float: right;margin-right: 10px"
                     v-if="user.role ==='ROLE_ADMIN'">
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
    <el-table :data="tableData" border stripe style="width: 100%" @selection-change="handleSelectionChange"
              highlight-current-row>
      <el-table-column type="selection" width="40px" align="center"/>
      <!--            sortable:排序操作-->
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="title" label="标题" align="center"/>
      <el-table-column prop="author" label="作者" align="center"/>
      <el-table-column prop="createTime" label="创建时间" align="center"/>
      <el-table-column prop="viewCount" label="查看次数" align="center"/>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template #default="scope">
          <el-button plain type="success" @click="details(scope.row)">查看</el-button>
          <el-button plain type="primary" @click="handleEdit(scope.row)"
                     v-if="scope.row.author===this.user.name">编辑
          </el-button>
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)"
                         v-if="user.role ==='ROLE_ADMIN'|| user.role ==='ROLE_USER'">
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
        <el-form :model="form" label-width="120px" :rules="rules" ref="pass">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" style="width: 50%"/>
          </el-form-item>
          <!--                    正文-->
          <div id="div1">

          </div>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save" :loading="loading">发布</el-button>
                    </span>
        </template>
      </el-dialog>
      <el-dialog v-model="vis" :title=detail_title width="50%">
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
import {serverIp} from "../../public/config";
//设置全局变量
let editor;

export default {
  name: 'Events',
  data() {
    return {
      count: 1,
      detail_title: '事件详情',
      loading: false,
      form: {},
      dialogVisible: false,
      title: '',
      author: '',
      timeHorizon: [],
      currentPage: 1,
      pageSize: 10,
      total: 10,
      tableData: [],
      detail: {},
      vis: false,
      editor: null,
      ids: [],
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      rules: {
        title: [
          {required: true, message: '标题不能为空', trigger: 'blur'},
          {min: 1, max: 10, message: '长度在1~100位之间', trigger: 'blur'},
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
    details(row) {
      request.post("/events/" + row.id);
      this.load();
      this.detail = row;
      this.vis = true;
      this.detail_title = this.detail.title;
    },
    reset() {
      this.title = '';
      this.author = '';
      this.timeHorizon = [];
      this.load();
    },
    load() {
      let time = this.timeHorizon;
      // console.log(time);
      request.get("/events", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          title: this.title,
          author: this.author,
          startTime: time[0],
          endTime: time[1]
        }
      }).then(res => {
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
          editor.config.uploadImgServer = 'http://' + serverIp + ':9090/files/editor/upload';
          editor.config.uploadFileName = "file";
          editor.create()
        }
        editor.txt.html("")
      })

    },
    save() {
      this.$refs.pass.validate((valid) => {
        if (valid) {
          this.loading = true
          setTimeout(() => {
            this.loading = false
          }, 1000)

          this.form.content = editor.txt.html(); //获取编辑器里面的值。然后赋予到实体form对象当中
          // console.log(typeof this.form.content)
          if (this.form.content === "") {
            this.$message.error("正文不能为空")
            return false;
          }
          this.form.author = this.user.name;
          request.post("/events", this.form).then(res => {
            // console.log(res);
            if (res.code === '0') {
              this.$message.success("编辑成功")
              this.load();//刷新表格数据
              this.dialogVisible = false
            } else {
              this.$message.error(res.msg)
            }
          });
        }
      })


      // else {
      //     this.$message.error("不是作者本人，编辑无效！")
      // }

    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true

      this.$nextTick(() => {
        if (!editor) {
          editor = new E('#div1');
          editor.config.uploadImgServer = 'http://' + serverIp + ':9090/files/editor/upload';
          editor.config.uploadFileName = "file";
          editor.create()
        }
        editor.txt.html(row.content)
      })
    }
    ,
    handleDelete(row) {
      // console.log(this.user)
      if (row.author === this.user.name || this.user.role === "ROLE_ADMIN") {
        this.id = row.id;
        request.delete("/events/" + this.id).then(res => {
          if (res.code === '0') {
            this.$message.success("删除成功")
          } else {
            this.$message.error(res.msg)
          }
          this.load();//刷新表格数据
        })
      } else {
        this.$message.error("不是你创建的不能删哦")
      }

    }
    ,
    handleSizeChange() {
      //改变当前每页个数的触发
      this.load()
    }
    ,
    handleCurrentChange() {
      //改变当前页数的触发
      this.load()
    }
    ,
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的事件");
        return
      }
      request.post("/events/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    }
    ,
    handleSelectionChange(val) {
      this.ids = val.map(v => v.id)
    }
    ,
  }
}
</script>
