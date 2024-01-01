<template>
  <div class="main-header">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add" v-if="user.role ===1|| user.role ===3">
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
      <el-select v-model="author" style="width: 15%;bottom: 2px" class="mr-10" placeholder="选择作者" clearable>
        <el-option
            v-for="item in authorList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
        />
      </el-select>
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
                     v-if="user.role ===1">
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
      <el-table-column prop="username" label="作者" align="center"/>
      <el-table-column prop="createTime" label="创建时间" align="center"/>
      <el-table-column prop="viewCount" label="查看次数" align="center"/>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template #default="scope">
          <el-button plain type="success" @click="details(scope.row)">查看</el-button>
          <el-button plain type="primary" @click="handleEdit(scope.row)"
                     v-if="scope.row.author===this.user.id">编辑
          </el-button>
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)"
                         v-if="user.role ===1|| user.id===scope.row.author">
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
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <el-dialog v-model="dialogVisible" title="编辑事件" width="50%">
        <el-form :model="form" label-width="120px" :rules="rules" ref="pass">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" style="width: 50%" maxlength="30" show-word-limit/>
          </el-form-item>
          <!--                    正文-->
          <div id="div1"></div>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save" :loading="loading">发布</el-button>
                    </span>
        </template>
      </el-dialog>
      <el-dialog v-model="vis" :title=detail.title width="50%">
        <el-card>
          <div v-html="detail.content" style="min-height: 100px"></div>
        </el-card>
        <el-card>
          <div>
            <h3 style="size: 10px;padding: 10px;opacity: .5">评论:</h3>
            <el-input type="textarea" :rows="2" show-word-limit maxlength="500" placeholder="留下你的友善发言吧~~~"
                      v-model="comment.content"></el-input>
            <div style="padding: 10px 0;display: flex;justify-content: flex-end">
              <el-button type="primary" @click="pushComment(detail.id)">留言</el-button>
            </div>
          </div>
          <div style="flex: 1;padding: 10px">收到留言（{{ this.commentsSize }}）</div>
          <div style="display: flex;padding: 10px" v-for="item in comments">
            <div style="text-align: center;width:40px">
              <el-image style="width: 30px;height: 30px;border-radius: 50%" :src="item.avatar"/>
            </div>
            <div style="flex: 5;padding: 0 10px">
              <div>
                {{ item.username }} ：{{ item.content }}
                <el-button type="danger" text="danger" @click="del(item.id,item.eventId)"
                           v-if="item.userId===user.id">删除
                </el-button>
              </div>
              <div style="color: #888;font-size: 8px">
                <span>{{ item.createTime }}</span>
                <el-button style="margin-left: 20px" type="text" @click="rePlay(item.id,item.eventId)">回复
                </el-button>
              </div>

              <!--一级回复内容-->
              <div style="background-color: #f4f4f4;padding: 10px" v-if="item.childList">
                <div style="display: flex" v-for="i in item.childList">
                  <div style="text-align: center;width:40px">
                    <el-image style="width: 30px;height: 30px;border-radius: 50%" :src="i.avatar"/>
                  </div>
                  <div style="display: flex;flex-direction:column">
                    <div style="padding-left: 10px;color: #888888">
                      {{ i.username }} ：{{ i.content }}
                      <el-button type="danger" text="danger" @click="del(i.id,i.eventId)" v-if="i.userId===user.id">删除
                      </el-button>
                    </div>
                    <div style="color: #888;font-size: 8px;padding: 10px">
                      <span>{{ i.createTime }}</span>
                    </div>
                  </div>

                </div>
              </div>

            </div>
          </div>
        </el-card>
      </el-dialog>

      <el-dialog v-model="replyVisible" width="50%" title="回复评论">
        <el-form :model="reply" label-width="120px">
          <el-input v-model="reply.content" type="textarea" show-word-limit maxlength="500"
                    placeholder="良言一句三冬暖，恶语伤人六月寒哦~~~"/>
        </el-form>
        <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="replyVisible = false">取消</el-button>
                        <el-button type="primary" @click="replySave()" :loading="loading">提交</el-button>
                    </span>
        </template>
      </el-dialog>
    </div>

  </div>
</template>

<script>

import request from "../utils/request";
import {Search, Delete} from "@element-plus/icons-vue";
import '@wangeditor/editor/dist/css/style.css' // 引入 css

import E from 'wangeditor'
import {serverIp, serverPort} from "../../public/config";
//设置全局变量
let editor;

export default {
  name: 'Events',
  data() {
    return {
      count: 1,
      loading: false,
      form: {},
      dialogVisible: false,
      title: '',
      author: '',
      authorList: [],
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
          {min: 1, max: 100, message: '长度在1~100位之间', trigger: 'blur'},
        ],
      },
      comment: {
        content: '',
        userId: null,
        isDelete: false,
        eventId: null,
        parentId: null,
        rootParentId: null
      },
      comments: [],
      commentsSize: 0,
      replyVisible: false,
      reply: {
        content: '',
        userId: null,
        eventId: null,
        isDelete: false,
        parentId: null,
        rootParentId: null
      },
    }
  },
  created() {
    this.load();
    request.get('/events/authorList').then(res => {
      this.authorList = res.data;
    })
  },
  setup() {
    return {
      Search,
      Delete
    }
  },
  methods: {
    queryComment(i) {
      request.get("/comment/" + i).then(res => {
        this.comments = res.data;
        if (!res.data) {
          return;
        }
        this.commentsSize = res.data.length;
      })
    },
    details(row) {
      console.log(row)
      this.comment.content = '';
      request.post("/events/" + row.id);
      setTimeout(() => {
        this.load();
      }, 500)
      this.detail = row;
      this.queryComment(row.id);
      this.vis = true;
    },
    reset() {
      this.title = '';
      this.author = '';
      this.timeHorizon = [];
      this.load();
    },
    load() {
      let time = this.timeHorizon;
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
      // 缓冲效果，等待页面元素加载完成
      this.$nextTick(() => {
        if (!editor) {
          //关联add弹窗里面的div，new一个editor对象
          editor = new E('#div1');
          //本地图片上传设置注意后端设置返回json格式
          editor.config.uploadImgServer = 'http://' + serverIp + ':' + serverPort + '/files/editor/upload';
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
          if (this.form.content === "") {
            this.$message.error("正文不能为空")
            return false;
          }
          this.form.author = this.user.id;
          request.post("/events", this.form).then(res => {
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
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true
      // this.form = row
      this.$nextTick(() => {
        if (!editor) {
          editor = new E('#div1');
          editor.config.uploadImgServer = 'http://' + serverIp + ':' + serverPort + '/files/editor/upload';
          editor.config.uploadFileName = "file";
          editor.create()
        }
        editor.txt.html(row.content)
      })
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/events/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
        this.load();
      })
    },
    handleSizeChange() {
      // 改变当前每页个数的触发
      this.load()
    },
    handleCurrentChange() {
      // 改变当前页数的触发
      this.load()
    },
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
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => v.id)
    },
    pushComment(id) {
      this.comment.userId = this.user.id
      this.comment.eventId = id;
      request.post("/comment", this.comment).then(res => {
        if (res.code === 400) {
          this.$message.warning(res.msg)
          return;
        }
        this.$message.success(res.msg)
      })
      setTimeout(() => {
        this.queryComment(id);
      }, 500)

      this.comment.content = '';
    },
    del(cId, eId) {
      request.delete("/comment/" + cId);
      setTimeout(() => {
        this.queryComment(eId);
      }, 500)
    },
    rePlay(cId, eId) {
      this.reply.content = '';
      this.replyVisible = true;
      this.reply.userId = this.user.id
      this.reply.eventId = eId;
      this.reply.parentId = cId;
    },
    replySave() {
      request.post("/comment", this.reply).then(res => {
        if (res.code === "400") {
          this.$message.warning(res.msg)
          return
        }
        this.$message.success(res.msg)
      })
      setTimeout(() => {
        this.queryComment(this.reply.eventId);
      }, 500)
      this.comment.content = '';
      this.reply.content = '';
      this.reply.parentId = null;
      this.replyVisible = false;
    }
  }
}
</script>
