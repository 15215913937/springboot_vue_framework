<template>
  <div style="margin: 20px;">
    <div style="display: flex;flex-direction: column;">
      <!--计划列表-->
      <div style="display:flex;height: 200px;border: #ffd700 solid;padding: 10px;text-align: center">
        <!--        当前计划进度区-->
        <div style="width: 200px;padding: 10px;display: flex;flex-direction: column">
          <span style="font-family: 华文楷体;font-size: 18px;height: 20px">当前计划完成进度</span>
          <div v-if="targets.length===0"
               style="flex:1;color: #888888;display: flex;justify-content: center;align-items: center">当前没有计划正在进行
          </div>
          <div v-else style="margin-top: 10px;flex:1;">
            <el-progress type="dashboard" :percentage=targets[0].schedule>
              <template #default="{ percentage }">
                <span style="color: red;font-family: 幼圆;font-size: larger;font-weight: bolder"
                      v-if="targets[0].schedule===100">已完成</span>
                <span class="percentage-value" v-else>{{ targets[0].schedule }}%</span>
                <br>
                <div style="cursor: pointer;margin-top: 10px">
                  <span class="percentage-label" @click="checkLatestTarget()">{{ targets[0].code }}</span>
                </div>
              </template>
            </el-progress>
          </div>
        </div>
        <!--        历史计划查看区-->
        <div style="flex: 1;padding: 10px;display: flex;flex-direction: column">
          <span style="font-family: 华文楷体;font-size: 18px;height: 20px">历史计划</span>
          <div v-if="targets.length===0"
               style="color: #888888;flex:1;display: flex;justify-content: center;align-items: center">暂无历史记录
          </div>
          <div style="display: flex;margin: 10px" v-else>
            <div style="flex: 1;" v-for="target in targets.slice(0,6)">
              <el-progress type="dashboard" :percentage=target.schedule>
                <template #default="{ percentage }">
                  <span style="color: red;font-family: 幼圆;font-size: larger;font-weight: bolder"
                        v-if="target.schedule===100">已完成</span>
                  <span style="color: #888888;font-family: 幼圆;font-size: larger;font-weight: bolder"
                        v-else-if="target.schedule!==100">未完成</span>
                  <span class="percentage-value" v-else>{{ target.schedule }}%</span>
                  <br>
                  <div style="cursor: pointer;margin-top: 10px">
                    <span class="percentage-label" @click="checkTarget(target.id)">{{ target.code }}</span>
                  </div>
                </template>
              </el-progress>
            </div>
          </div>
        </div>
        <!--        操作区-->
        <div style="width: 150px;display: flex;flex-direction: column">
          <div class="alignCenter">
            <el-button type="success" @click="addTarget(user.id)">新增计划</el-button>
          </div>
          <div class="alignCenter">
            <el-button @click="menu(user.id)">历史计划</el-button>
          </div>
        </div>
      </div>
      <!--当天运动记录-->
      <div style="flex: 1;padding: 10px">
        <!--    基本身体信息更新-->
        <div class="bodyInfo">
          <div class="alignCenter_width150">
            <el-select v-model="changeTo" class="m-2" style="width: 100px">
              <el-option
                  v-for="item in select"
                  :key="item.key"
                  :label="item.label"
                  :value="item.label"
              />
            </el-select>

          </div>
          <div class="alignCenter">
            <!--            基础信息-->
            <el-form :inline="true" :model="bodyInfo" class="demo-form-inline" v-if="changeTo==='基础信息'">
              <el-form-item label="身高" class="bodySingle">
                <el-input style="width: 65px" v-model.number="bodyInfo.height" maxlength="3"/>
                <span style="margin-left: 10px">cm</span>
              </el-form-item>
              <el-form-item label="体重" class="bodySingle">
                <el-input style="width: 65px" v-model.trim="bodyInfo.weight" maxlength="5"/>
                <span style="margin-left: 10px">kg</span>
              </el-form-item>
              <el-form-item label="身体质量指数（BMI）:" class="bodySingle">
                <h3>{{
                    (!this.bodyInfo.weight || !this.bodyInfo.weight) ? 0 : (this.bodyInfo.weight / (this.bodyInfo.height * this.bodyInfo.height / 10000)).toFixed(1)
                  }}</h3>
                <el-icon style="margin-left: 20px;cursor: pointer" @click="tips()">
                  <QuestionFilled/>
                </el-icon>
              </el-form-item>
              <el-form-item class="bodySingle">
                <el-tag v-if="bmi>0&&bmi<=18.4">偏瘦</el-tag>
                <el-tag type="success" v-else-if="bmi>18.4&&bmi<=23.9">正常</el-tag>
                <el-tag type="warning" v-else-if="bmi>23.9&&bmi<=27.9">偏胖</el-tag>
                <el-tag type="error" v-else-if="bmi>27.9">肥胖</el-tag>
                <el-tag type="info" v-else>未知</el-tag>
              </el-form-item>
            </el-form>
            <!--            围度-->
            <el-form :inline="true" :model="bodyInfo" class="demo-form-inline" v-else>
              <el-form-item label="肩围" class="bodySingle">
                <el-input style="width: 65px" v-model.trim="bodyInfo.shoulderWide" maxlength="4"/>
                <span style="margin-left: 10px">cm</span>
              </el-form-item>
              <el-form-item label="胸围" class="bodySingle">
                <el-input style="width: 65px" v-model.trim="bodyInfo.bust" maxlength="4"/>
                <span style="margin-left: 10px">cm</span>
              </el-form-item>
              <el-form-item label="腰围" class="bodySingle">
                <el-input style="width: 65px" v-model.trim="bodyInfo.waistline" maxlength="4"/>
                <span style="margin-left: 10px">cm</span>
              </el-form-item>
              <el-form-item label="臀围" class="bodySingle">
                <el-input style="width: 65px" v-model.trim="bodyInfo.hipline" maxlength="4"/>
                <span style="margin-left: 10px">cm</span>
              </el-form-item>
            </el-form>
          </div>
          <div class="alignCenter_width150">
            <el-button type="primary" @click="onSubmit(user.id,changeTo)">更新</el-button>
          </div>
        </div>
        <!--        运动集-->
        <div style="display: flex">
          <!--          今日活动-->
          <div class="alignCenter_width150">
            <span>今日活动</span>
          </div>
          <div style="flex:1;border: #409EFF solid;padding: 0 10px;height: 50px;display: flex;align-items: center;">
            <el-tag
                v-for="tag in newActivityMarks"
                :key=tag
                closable
                :disable-transitions="false"
                @close="handleClose(tag)"
                style="margin-right: 10px"
            >
              {{ tag }}
            </el-tag>
            <el-input
                v-if="inputVisible"
                ref="saveTagInput"
                v-model="inputValue"
                style="width: 60px"
                size="small"
                @keyup.enter="handleInputConfirm"
                @blur="handleInputConfirm"
            />
            <el-button v-else class="button-new-tag ml-1" size="small" @click="showInput">
              + 新 活 动
            </el-button>
          </div>
          <!--          上一次活动-->
          <div class="alignCenter_width150">
            <span>上一次活动</span>
          </div>
          <div style="flex:1;border: #409EFF solid;padding: 0 10px;height: 50px;display: flex;align-items: center;">
            <el-tag
                v-for="tag in latestActivityMarks"
                :key=tag
                style="margin-right: 10px"
            >
              {{ tag }}
            </el-tag>
          </div>
        </div>

      </div>
    </div>
    <!--  弹窗-->
    <div>
      <div>
        <el-dialog v-model="dialogVisible" title="我的计划" width="30%">
          <el-form :model="newTarget" label-width="120px" :rules="rules" ref="pass">
            <el-form-item label="计划代号" prop="code">
              <el-input v-model="newTarget.code" style="width: 80%" show-word-limit maxlength="5" autocomplete="off"/>
            </el-form-item>
            <el-form-item label="计划开始日期" prop="start_time">
              <el-date-picker
                  v-model="newTarget.start_time"
                  type="date"
                  clearable
                  style="width: 80%"
                  format="YYYY/MM/DD"
                  value-format="YYYY-MM-DD"
              />
            </el-form-item>
            <el-form-item label="计划结束日期" prop="end_time">
              <el-date-picker
                  v-model="newTarget.end_time"
                  type="date"
                  clearable
                  style="width: 80%"
                  format="YYYY/MM/DD"
                  value-format="YYYY-MM-DD"
              />
            </el-form-item>
            <el-form-item label="级别" prop="level">
              <el-radio-group v-model="newTarget.level">
                <el-radio-button label=2>轻松</el-radio-button>
                <el-radio-button label=1>正常</el-radio-button>
                <el-radio-button label=0>困难</el-radio-button>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="描述" prop="content">
              <el-input type="textarea" v-model="newTarget.content" style="width: 80%" show-word-limit maxlength="50"
                        autocomplete="off"/>
            </el-form-item>
          </el-form>
          <template #footer>
                    <span class="dialog-footer">
                      <div v-if="this.operate">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="submitTarget(user.id)" :loading="loading">提交</el-button>
                      </div>
                      <div v-else>
                        <el-button @click="dialogVisible = false">确定</el-button>
                      </div>
                    </span>
          </template>
        </el-dialog>
      </div>
      <div>
        <el-dialog v-model="historyDialogVisible" title="历史计划">
          <el-table :data="targets" height="250" style="width: 100%" stripe>
            <el-table-column prop="id" label="ID" width="100" align="center"/>
            <el-table-column prop="code" label="代号" align="center"/>
            <el-table-column prop="level" label="级别" align="center">
              <template #default="scope">
                <el-tag type="success" v-if="scope.row.level === 2">轻松</el-tag>
                <el-tag v-if="scope.row.level === 1">正常</el-tag>
                <el-tag type="danger" v-if="scope.row.level === 0">困难</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="startTime" label="计划开始时间" align="center"/>
            <el-table-column prop="endTime" label="计划结束时间" align="center"/>
            <el-table-column prop="status" label="状态" align="center">
              <template #default="scope">
                <el-tag effect="plain" type="info" v-if="scope.row.status === 0">未开始</el-tag>
                <el-tag effect="plain" type="" v-if="scope.row.status === 1">进行中</el-tag>
                <el-tag effect="plain" type="success" v-if="scope.row.status === 2">已完成</el-tag>
                <el-tag effect="plain" type="danger" v-if="scope.row.status === 3">未完成</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="schedule" label="进度" align="center"/>
          </el-table>
          <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="historyDialogVisible = false">确定</el-button>
                    </span>
          </template>
        </el-dialog>
      </div>
    </div>

  </div>
</template>

<script>
import request from "../utils/request";
import {ElMessageBox} from 'element-plus'

const {nextTick} = require("vue");

let n = new Date()
let year = n.getFullYear()
let month = n.getMonth() + 1 > 9 ? n.getMonth() + 1 : '0' + (n.getMonth() + 1)
let day = n.getDate() > 9 ? n.getDate() : '0' + n.getDate()
let nowDate = year + '-' + month + '-' + day

export default {
  name: "HealthManagement",
  data() {
    return {
      newActivityMarks: [],
      latestActivityMarks: [],
      inputValue: '',
      inputVisible: false,
      checked: false,
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      changeTo: "基础信息",
      select: [
        {
          value: 1,
          label: "基础信息"
        },
        {
          value: 2,
          label: "围度"
        }
      ],
      bmi: 0,
      targets: [{
        schedule: "",
        code: "",
      }],
      newTarget: {
        uid: "",
        code: "",
        content: "",
        startTime: "",
        endTime: "",
        level: 1
      },
      dialogVisible: false,
      loading: false,
      operate: true,
      historyDialogVisible: false,
      bodyInfo: {
        uid: "",
        height: "",
        weight: "",
        bust: "",
        waistline: "",
        hipline: "",
        shoulderWide: "",
        activities: ""
      }
    }
  },
  created() {
    this.load();
  },
  methods: {
    // 页面基础数据加载
    load() {

      request.post('/health/queryLatestInfo/' + this.user.id).then(res => {
        if (res.data.length === 0) {
          return
        }
        this.bodyInfo = {
          height: res.data[0].height,
          weight: (res.data[0].weight / 2 / 10).toFixed(1),
          shoulderWide: (res.data[0].shoulderWide / 2 / 10).toFixed(1),
          bust: (res.data[0].bust / 2 / 10).toFixed(1),
          waistline: (res.data[0].waistline / 2 / 10).toFixed(1),
          hipline: (res.data[0].hipline / 2 / 10).toFixed(1),
        };

        let expectDate = res.data[0].createTime;
        expectDate = expectDate.split(" ")

        console.log(res.data.length)
        if (res.data.length !== 0 && expectDate[0] === nowDate) {
          this.newActivityMarks = res.data[0].activityMarks;
        }
        if (res.data.length !== 0 && expectDate[0] !== nowDate) {
          this.latestActivityMarks = res.data[0].activityMarks;
        }
        if (res.data.length > 1) {
          this.latestActivityMarks = res.data[0].activityMarks;
        }
        this.bmi = (this.bodyInfo.weight / (this.bodyInfo.height * this.bodyInfo.height / 10000)).toFixed(1)
      });
      request.post('/target/queryTargets/' + this.user.id).then(res => {
        this.targets = res.data;
      })
    },
    // 查看小知识
    tips() {
      const tips = '<p>身体质量指数是国际上衡量人体胖瘦程度以及是否健康的一个常用指标。<small>（计算公式为：BMI = 体重 ÷ 身高²）</small></p><b/>BMI中国标准：<ul><li>≤18.4属于偏瘦</li><li>18.5~23.9属于正常</li><li>24.0~27.9属于偏胖</li><li>≥28属于肥胖</li></ul>'
      ElMessageBox.alert(tips, '小知识', {
        dangerouslyUseHTMLString: true,
        confirmButtonText: '确定',
        callback: () => {
        }
      })
    },
    onSubmit(uid, i) {
      let baseData = 2 * 10;
      let body = {
        uid: uid,
        height: this.bodyInfo.height,
        weight: this.bodyInfo.weight * baseData,
        bust: this.bodyInfo.bust * baseData,
        waistline: this.bodyInfo.waistline * baseData,
        hipline: this.bodyInfo.hipline * baseData,
        shoulderWide: this.bodyInfo.shoulderWide * baseData,
        activityMarks: this.newActivityMarks
      }
      let is_simple = 1;
      if (i === "围度") {
        is_simple = 0;
      }
      request.post("/health/save/" + is_simple, body).then(res => {
        if (res.code !== "0") {
          this.$message.error(res.msg)
          if (i === 1) {
            this.bodyInfo = {
              height: "",
              weight: "",
            }
          } else {
            this.bodyInfo = {
              bust: "",
              waistline: "",
              hipline: "",
              shoulderWide: ""
            }
          }
          return;
        }
        this.$message.success(res.msg)
      });
      setTimeout(() => {
        this.load();
      }, 500)
    },
    checkLatestTarget() {
      this.operate = false;
      request.get('/target/' + this.targets[0].id).then(res => {
        this.dialogVisible = true;
        this.newTarget = res.data
      })
    },
    checkTarget(id) {
      this.operate = false;
      request.get('/target/' + id).then(res => {
        this.dialogVisible = true;
        this.newTarget = res.data
      })
    },
    addTarget() {
      this.dialogVisible = true;
      this.operate = true;
      this.newTarget = {}
    },
    submitTarget(uid) {
      // setTimeout(() => {
      //   this.loading = true;
      // }, 500);
      this.newTarget.uid = uid;
      console.log(this.newTarget.startTime)
      console.log(typeof this.newTarget.startTime)
      console.log(this.newTarget.endTime)
      console.log(typeof this.newTarget.endTime)
      // request.post('/target', this.newTarget).then(res => {
      //   this.$message.success(res.msg);
      //   this.newTarget = {}
      // })
    },
    menu() {
      this.historyDialogVisible = true;
    },
    handleClose(tag) {
      this.newActivityMarks.splice(this.newActivityMarks.indexOf(tag), 1);
    },
    showInput() {
      this.inputVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveTagInput.$refs.input.focus();
      });
    },

    handleInputConfirm() {
      let inputValue = this.inputValue;
      if (inputValue) {
        this.newActivityMarks.push(inputValue);
      }
      this.inputVisible = false;
      this.inputValue = '';
    },
  }
}
</script>

<style scoped>
.bodyInfo {
  display: flex;
  height: 100px;
  text-align: center;
}

.alignCenter_width150 {
  width: 150px;
  display: flex;
  align-items: center;
  justify-content: center
}

.alignCenter {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center
}

.demo-form-inline {
  display: flex;
}

.bodySingle {
  margin: 0 10px;
}

</style>