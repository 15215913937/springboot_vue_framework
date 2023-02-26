<template>
  <div style="margin: 20px;display: flex;flex-direction: column">
    <div style="height: 60px">
      <el-form :inline="true" :model="bodyInfo" class="demo-form-inline">
        <el-form-item>
          <el-button type="primary" @click="onSubmit(user.id)">更新</el-button>
        </el-form-item>
        <el-form-item label="身高">
          <el-input style="width: 65px" v-model="bodyInfo.height" onkeyup="value=value.replace(/[^0-9]/g,'')"
                    maxlength="3"/>
          <span style="margin-left: 10px">cm</span>
        </el-form-item>
        <el-form-item label="体重">
          <el-input style="width: 65px" v-model.trim="bodyInfo.weight" maxlength="5"
                    @input="limitInput($event,'weight')"/>
          <span style="margin-left: 10px">Kg</span>
        </el-form-item>
        <el-form-item label="身体质量指数（BMI）:">
          <h3>{{
              (!this.bodyInfo.weight || !this.bodyInfo.weight) ? 0 : (this.bodyInfo.weight / (this.bodyInfo.height * this.bodyInfo.height / 10000)).toFixed(1)
            }}</h3>
          <el-icon style="margin-left: 20px;cursor: pointer" @click="tips()">
            <QuestionFilled/>
          </el-icon>
        </el-form-item>
        <el-form-item>
          <el-tag v-if="bmi>0&&bmi<=18.4">偏瘦</el-tag>
          <el-tag type="success" v-else-if="bmi>18.4&&bmi<=23.9">正常</el-tag>
          <el-tag type="warning" v-else-if="bmi>23.9&&bmi<=27.9">偏胖</el-tag>
          <el-tag type="error" v-else-if="bmi>27.9">肥胖</el-tag>
          <el-tag type="info" v-else>未知</el-tag>
        </el-form-item>
      </el-form>
    </div>

    <div style="display: flex;flex-direction: column;flex: 1;">
      <div style="display:flex;flex: 1;border: #ffd700 solid;padding: 10px;text-align: center">
        <!--        当前目标进度区-->
        <div style="width: 200px;padding: 10px;display: flex;flex-direction: column">
          <span style="font-family: 华文楷体;font-size: 18px;height: 20px">当前目标完成进度</span>
          <div v-if="targets.length===0"
               style="flex:1;color: #888888;display: flex;justify-content: center;align-items: center">当前没有目标正在进行
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
        <!--        历史目标查看区-->
        <div style="flex: 1;padding: 10px;display: flex;flex-direction: column">
          <span style="font-family: 华文楷体;font-size: 18px;height: 20px">历史目标</span>
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
          <div style="flex: 1;display: flex;align-items: center;justify-content: center">
            <el-button @click="addTarget(user.id)">新增目标</el-button>
          </div>
          <div style="flex: 1;display: flex;align-items: center;justify-content: center">
            <el-button>历史目标</el-button>
          </div>
        </div>
      </div>

      <div style="flex: 4">
        当天运动信息录入区域
      </div>
    </div>
    <!--  弹窗-->
    <div>
      <el-dialog v-model="dialogVisible" title="我的目标" width="30%">
        <el-form :model="newTarget" label-width="120px" :rules="rules" ref="pass">
          <el-form-item label="目标代号" prop="code">
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
            <el-radio v-model="newTarget.level" label=2 size="large">轻松</el-radio>
            <el-radio v-model="newTarget.level" label=1 size="large">正常</el-radio>
            <el-radio v-model="newTarget.level" label=0 size="large">困难</el-radio>
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
  </div>
</template>

<script>
import request from "../utils/request";
import {ElMessageBox} from 'element-plus'

export default {
  name: "HealthManagement",
  data() {
    return {
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      bmi: 0,
      bodyInfo: {
        uid: "",
        height: "",
        weight: "",
      },
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
      operate: true
    }
  },
  created() {
    this.load();
  },
  methods: {
    limitInput(value, name) {
      let val = (value && value.split("")) || [];
      let reg1 = /\d/;
      let reg2 = /\./;
      // 第一个字符不能为小数点
      if (val[0] === ".") {
        this.bodyInfo[name] = null;
        return;
      }
      // 过滤掉除数字和小数点外的字符
      val = val.filter((e) => reg1.test(e) || reg2.test(e));
      // 匹配小数点后只能有两位小数
      // 解释一下这个match正则规格
      // ^\d* 是指以数字开头，后面允许输入0到多位数字
      // (\.?) 是指只允许一个小数点
      // \d{0,1} 是指只允许0到1位小数
      this.bodyInfo[name] = val.join("").match(/^\d*(\.?\d{0,1})/g)[0] || null;
    },
    // 页面基础数据加载
    load() {
      request.post('/health/queryLatestInfo/' + this.user.id).then(res => {
        if (res.data.length === 0) {
          return
        }
        this.bodyInfo = {
          height: res.data[0].height,
          weight: (res.data[0].weight / 2 / 10).toFixed(1)
        };
        this.bmi = (this.bodyInfo.weight / (this.bodyInfo.height * this.bodyInfo.height / 10000)).toFixed(1)
      });
      request.post('/target/queryTargets/' + this.user.id).then(res => {
        console.log(res)
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
    onSubmit(uid) {
      let bodyInfo;
      bodyInfo = {
        uid: uid,
        height: Number(this.bodyInfo.height),
        weight: this.bodyInfo.weight * 2 * 10
      }
      request.post("/health", bodyInfo).then(res => {
        if (res.code !== "0") {
          this.$message.error(res.msg)
          this.bodyInfo = {
            height: "",
            weight: "",
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
      setTimeout(() => {
        this.loading = true;
      }, 500);
      this.newTarget.uid = uid;
      console.log(this.newTarget.startTime)
      console.log(typeof this.newTarget.startTime)
      console.log(this.newTarget.endTime)
      console.log(typeof this.newTarget.endTime)
      // request.post('/target', this.newTarget).then(res => {
      //   this.$message.success(res.msg);
      //   this.newTarget = {}
      // })
    }

  }

}
</script>

<style scoped>

</style>