<template>
  <div class="main-header">
    <div class="mtb-10">
      <el-button type="primary" @click="openCollect">
        <el-icon>
          <VideoPlay/>
        </el-icon>
        &nbsp开始采集
      </el-button>
    </div>
    <div class="container">
      <div class="search">
        <el-select v-model="search.userInfoId" class="mr-10" placeholder="测试者" clearable>
          <el-option v-for="name in names" :key="name.id" :label="name.name" :value="name.id"></el-option>
        </el-select>
        <el-select v-model="search.mat" class="mr-10" placeholder="舒适层" clearable>
          <el-option v-for="mat in mats" :key="mat.value" :label="mat.label" :value="mat.value"></el-option>
        </el-select>
        <el-select v-model="search.actualSleepPosition" class="mr-10" placeholder="实际睡姿" clearable>
          <el-option v-for="sp in sleepPositions" :key="sp.value" :label="sp.label" :value="sp.value"></el-option>
        </el-select>
        <el-select v-model="search.project" style="margin: 0 10px 10px 0;width: 15%" placeholder="测试项目" clearable>
          <el-option v-for="project in projects" :key="project.value" :label="project.label"
                     :value="project.value"></el-option>
        </el-select>
        <el-select v-model="search.isReg" class="mr-10" placeholder="识别结果" clearable>
          <el-option v-for="r in res" :key="r.value" :label="r.label" :value="r.value"></el-option>
        </el-select>

        <el-button class="mb-10" type="primary" @click="load">查询</el-button>
        <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
      </div>

      <div class="search-button">
        <el-popconfirm title="确定要删除吗" @confirm="deleteBatch">
          <template #reference>
            <el-button class="mb-10" type="danger" v-if="user.role===1 || user.role===3">
              <el-icon>
                <Delete/>
              </el-icon>
              &nbsp批量删除
            </el-button>
          </template>
        </el-popconfirm>
      </div>
    </div>
    <el-table
        :data="tableData"
        border
        stripe
        highlight-current-row
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="40px" align="center"/>
      <el-table-column prop="id" label="ID" align="center" width="50px"/>
      <el-table-column prop="name" label="测试者" align="center">
      </el-table-column>
      <el-table-column prop="actualSleepPosition" label="实际睡姿" align="center">
        <template #default="scope">
          <el-tag effect="plain" type="danger" v-if="scope.row.actualSleepPosition===0">无人</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===1">仰卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===2">左侧卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===3">右侧卧</el-tag>
          <el-tag effect="plain" v-else>坐姿</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="recognition" label="识别睡姿" align="center">
        <template #default="scope">
          <el-tag effect="plain" type="danger" v-if="scope.row.recognition===0">无人</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===1">仰卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===3||scope.row.recognition===4">侧卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===5">坐姿</el-tag>
          <el-tag effect="plain" v-else type="info">未知</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="isReg" label="结果" align="center">
        <template #default="scope">
          <el-tag effect="dark" type="success" v-if="scope.row.isReg">识别成功</el-tag>
          <el-tag effect="dark" type="danger" v-if="!scope.row.isReg">未识别</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="记录时间" align="center"/>
      <el-table-column fixed="right" label="操作" align="center" :width="200">
        <template #default="scope">
          <el-button plain type="primary" @click="viewDetails(scope.row)">详情</el-button>
          <el-button type="info" @click="viewConfig(scope.row)">配置</el-button>
        </template>
      </el-table-column>
      <el-pagination small layout="prev, pager, next" :total="50"/>
    </el-table>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:current-page="search.pageNum"
          v-model:pageSize="search.pageSize"
          :page-sizes="[20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="search.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <!-- 采集功能弹窗-->
      <el-dialog v-model="collectDialogVisible" append-to-body @before-close="handleClose">
        <div style="display: flex; flex-direction: column; justify-content: space-between;">
          <div class="header">
            <el-form :model="CollectBaseData" :rules="collectRules" ref="collectRef" label-width="120px">
              <div class="form-item">
                <el-form-item label="测试人" prop="userInfoId">
                  <el-select v-model="CollectBaseData.userInfoId" style="width: 80%" clearable>
                    <el-option
                        v-for="item in names"
                        :key="item.id"
                        :label="item.name"
                        :value="item.id"
                    />
                  </el-select>
                </el-form-item>
                <el-form-item label="采集床垫ID" prop="bedId">
                  <el-input type="number" maxlength="10" v-model="CollectBaseData.bedId"/>
                </el-form-item>
                <el-form-item label="舒适层">
                  <el-radio-group v-model="CollectBaseData.mat">
                    <el-radio label="1">STAND</el-radio>
                    <el-radio label="2">PLUS</el-radio>
                    <el-radio label="3">PRO</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="自动模式">
                  <el-radio-group v-model="CollectBaseData.isAutomode">
                    <el-radio label="true">开</el-radio>
                    <el-radio label="false">关</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="微调">
                  <el-radio-group v-model="CollectBaseData.isFineAdjustment">
                    <el-radio label="true">开</el-radio>
                    <el-radio label="false">关</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="监测周期(秒)">
                  <el-input-number v-model="CollectBaseData.period" :step="10" min="0"/>
                </el-form-item>
                <el-form-item label="采集方式">
                  <el-radio-group v-model="mode">
                    <el-radio label="0">随机</el-radio>
                    <el-radio label="1">顺序</el-radio>
                    <el-radio label="2">按床垫状态（随机姿势）</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-form>
          </div>
          <div class="status-container">
            <div class="fixed-box">
              <h3>监测记录</h3>
              <div class="content">
                <div v-for="item in latestStatus" :key="item.id" class="status-item">
                  <p class="status">状态: {{ item.status }}</p>
                  <p class="time">时间: {{ item.time }}</p>
                </div>
              </div>
            </div>
          </div>
          <div class="footer-btn">
            <el-button type="primary" @click="startMonitoring" v-if="!isMonitoring">开始监测</el-button>
            <el-button type="danger" @click="stopMonitoring('已终止')" v-if="isMonitoring">终止</el-button>
          </div>
        </div>
      </el-dialog>

      <!--  记录详情弹窗-->
      <el-dialog v-model="viewDetailsDialogVisible" :title="title" append-to-body :width="1000">
        <div style="display: flex;flex-direction: column">
          <div style="height: 30px;margin-bottom: 10px;display: flex;padding-left: 20px">
            <el-switch
                v-model="hotOrPressure"
                active-text="热力图"
                inactive-text="压力图"
            />
            <div style="position:absolute;right: 40px">
              <el-button type="primary" @click="copyAll()">
                一键全部复制
              </el-button>
            </div>

          </div>
          <div style="flex: 1">
            <div v-if="hotOrPressure">
              <el-scrollbar :height="600">
                <el-row style="display: flex">
                  <el-col v-for="p in pressures" :span="6" :key="p.time"
                          style="display: flex; justify-content: center; padding: 10px">
                    <div style="width: 100%; display: flex; flex-direction: column">
                      <div style="flex: 1; display: flex; justify-content: center;">
                        <img :src="'data:image/jpeg;base64,' +p.hotBase64" alt="Image" @load="imageLoaded = true"
                             :height="400">
                      </div>
                      <div
                          style="display:flex;height: 30px;align-items: center;justify-content: center;font-size: 10px">
                        <el-icon @click="copyData(p.pressure)" style="cursor: pointer;color: #409EFF">
                          <DocumentCopy/>
                        </el-icon>
                        <span :style="getTimeStyles(p.time)">&nbsp&nbsp{{ p.time }}</span>
                      </div>
                    </div>
                  </el-col>
                </el-row>
              </el-scrollbar>
            </div>
            <div v-else>
              <el-scrollbar style="height: 600px">
                <el-row style="display: flex">
                  <el-col v-for="p in pressures" :span="6" :key="p.time"
                          style="display: flex; justify-content: center; padding: 10px">
                    <div style="width: 100%; display: flex; flex-direction: column">
                      <div style="flex: 1; display: flex; justify-content: center">
                        <div class="grid">
                          <div v-for="(row, rowIndex) in getTwoDimensionalData(p.pressure)" :key="rowIndex" class="row">
                            <div v-for="(cell, colIndex) in row" :key="colIndex" :style="getCellStyles(cell)"
                                 class="cell">
                              {{ cell }}
                            </div>
                          </div>
                        </div>
                      </div>
                      <div
                          style="display:flex;height: 30px;align-items: center;justify-content: center;font-size: 10px">
                        <el-icon @click="copyData(p.pressure)" style="cursor: pointer;color: #409EFF">
                          <DocumentCopy/>
                        </el-icon>
                        <span :style="getTimeStyles(p.time)">&nbsp&nbsp{{ p.time }}</span>
                      </div>
                    </div>
                  </el-col>
                </el-row>
              </el-scrollbar>
            </div>
          </div>
        </div>
      </el-dialog>
      <!--  配置弹窗-->
      <el-dialog
          title="配置"
          v-model="configDialogVisible"
          append-to-body
          :width="300"
      >
        <div style="display: flex;align-items: center;justify-content: center">
          <el-card style="width: 80%">
            <el-form label-width="80px" :model="configInfo">
              <el-form-item label="采集床垫" prop="bedId">
                <el-tag>{{ configInfo.bedId }}</el-tag>
              </el-form-item>
              <el-form-item label="测试项目" prop="project">
                <el-tag v-if="configInfo.project===1">正中识别</el-tag>
                <el-tag v-else>靠边识别</el-tag>
              </el-form-item>
              <el-form-item label="舒适层" prop="mat">
                <el-tag v-if="configInfo.mat===1">STAND</el-tag>
                <el-tag v-else-if="configInfo.mat===2">PLUS</el-tag>
                <el-tag v-else-if="configInfo.mat===3">PRO</el-tag>
              </el-form-item>
              <el-form-item label="自动模式" prop="isAutomode">
                <el-tag effect="plain" type="success" v-if="configInfo.isAutomode">开启</el-tag>
                <el-tag effect="plain" type="danger" v-else>关闭</el-tag>
              </el-form-item>
              <el-form-item label="微调" prop="isFineAdjustment">
                <el-tag effect="plain" type="success" v-if="configInfo.isFineAdjustment">开启</el-tag>
                <el-tag effect="plain" type="danger" v-else>关闭</el-tag>
              </el-form-item>
              <el-form-item label="采集周期" prop="period">
                <el-tag>{{ configInfo.period }}</el-tag>
              </el-form-item>
            </el-form>
          </el-card>
        </div>
      </el-dialog>
    </div>
  </div>

</template>

<script>
import request from "../utils/request";
import {Search, Delete, Upload} from "@element-plus/icons-vue";
import moment from 'moment';

export default {
  name: "DataAcquisition",
  data() {
    return {
      search: {
        userInfoId: null,
        mat: null,
        actualSleepPosition: null,
        project: null,
        isReg: null,
        pageNum: 1,
        pageSize: 20,
        total: '',
      },
      mats: [
        {value: 1, label: 'STAND'},
        {value: 2, label: 'PLUS'},
        {value: 3, label: 'PRO'},
      ],
      sleepPositions: [
        {value: 5, label: '无人'},
        {value: 1, label: '仰卧'},
        {value: 2, label: '左侧卧'},
        {value: 3, label: '右侧卧'},
        {value: 4, label: '坐姿'},

      ],
      projects: [
        {value: 1, label: '正中识别'},
        {value: 2, label: '靠边识别'},
      ],
      res: [
        {value: false, label: '未识别'},
        {value: true, label: '识别成功'}
      ],
      names: [],
      tableData: [],
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      collectDialogVisible: false,
      viewDetailsDialogVisible: false,
      title: '',
      pressures: [],
      WcellSize: 25,
      HcellSize: 15,
      fontSize: 10,
      fontColor: '#000000',
      CollectBaseData: {
        userInfoId: '',
        bedId: '1457',
        mat: "1",
        period: 30,
        isAutomode: "true",
        isFineAdjustment: "true",
        actualSleepPosition: null,
        project: 1,
        recognition: null
      },
      mode: "0",
      modePlan: {
        1: "正中",
        2: "靠边",
        3: "仰卧",
        4: "左侧卧",
        5: "右侧卧"
      },
      collectRules: {
        userInfoId: [
          {required: true, message: '测试人未选择', trigger: 'blur'}
        ],
        bedId: [
          {required: true, message: '床垫ID未填', trigger: 'blur'}
        ],
      },
      statusList: [],
      step: 1,
      intervalId: null,
      isMonitoring: false,
      ids: [],
      hotOrPressure: false,
      row: {
        createTime: ''
      },
      maxHighlightedData: 3, // 设置要高亮显示的最大数据数量
      configDialogVisible: false,
      configInfo: {
        "bedId": "",
        "period": null,
        "mat": null,
        "isAutomode": "",
        "isFineAdjustment": "",
        "project": null
      },
      mattressStatus: {},
      befor_mattressStatus: {},
      waitCollect: false
    }
  },
  created() {
    this.load();
    request.get('/user-info/all').then(res => {
      this.names = res.data
    })
  },
  computed: {
    latestStatus() {
      return this.statusList;
    },
    getMaxFilteredPressures() {
      const specifiedTime = new Date(this.row.createTime);
      const filteredPressures = this.pressures.filter(p => new Date(p.time) < specifiedTime);
      return filteredPressures.slice(-this.maxHighlightedData).reverse();
    }
  },
  setup() {
    return {
      Search,
      Delete,
      Upload
    }
  },
  methods: {
    load() {
      request.get("/sleep-position-collect/findPage", {
        params: {
          userInfoId: this.search.userInfoId,
          mat: this.search.mat,
          actualSleepPosition: this.search.actualSleepPosition,
          project: this.search.project,
          isReg: this.search.isReg,
          pageNum: this.search.pageNum,
          pageSize: this.search.pageSize
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.search.total = res.data.total;
      });
    },
    reset() {
      this.search = {
        code: '',
        mat: '',
        batch: '',
        coefficient: '',
        status: '',
        pageNum: 1,
        pageSize: 20
      };
      this.load();
    },
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的记录");
        return
      }
      request.post("/sleep-position-collect/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功");
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    playSound(text) {
      const synthesis = window.speechSynthesis;
      const utterance = new SpeechSynthesisUtterance(text);

      synthesis.speak(utterance);
    },
    copyData(data) {
      navigator.clipboard.writeText(data)
          .then(() => {
            this.$message.success("已成功复制数据");
          })
          .catch((error) => {
            this.$message.error("复制数据失败:", error)
          });
    },
    copyAll() {
      const copyAll = []
      for (const p of this.pressures) {
        copyAll.push("压力值")
        copyAll.push(p.pressure)
        copyAll.push("时间")
        copyAll.push(p.time)
      }
      this.copyData(copyAll)
    },
    getRandomInt1_3() {
      return Math.floor(Math.random() * 3) + 1
    },
    getRandomInt1_2() {
      return Math.floor(Math.random() * 2) + 1
    },
    viewDetails(row) {
      this.viewDetailsDialogVisible = true
      this.pressures = []
      this.row.createTime = ''
      this.row.createTime = row.createTime
      this.maxHighlightedData = row.period / 10
      this.title = row.id
      request.get('/sleep-position-collect/pressureListByOne', {
        params: {
          "id": row.id,
          "bedId": row.bedId,
          "period": row.period,
          "createTime": row.createTime
        }
      }).then(res => {
        this.pressures = res.data
      })
    },
    viewConfig(data) {
      this.configDialogVisible = true
      this.configInfo = data
    },
    getCellStyles(cell) {
      return {
        width: `${this.WcellSize}px`,
        height: `${this.HcellSize}px`,
        backgroundColor: this.getCellBackgroundColor(cell),
        color: this.fontColor,
        fontSize: `${this.fontSize}px`
      };
    },
    getTimeStyles(time) {
      const isHighlighted = this.getMaxFilteredPressures.some(p => p.time === time);
      return {
        color: isHighlighted ? "red" : this.fontColor,
        "font-weight": isHighlighted ? "bold" : "normal",
      };
    },
    getTwoDimensionalData(pressure) {
      const data = pressure.split(",");
      const rows = 21;
      const columns = 8;
      const result = [];

      for (let i = 0; i < rows; i++) {
        const row = data.slice(i * columns, (i + 1) * columns);
        result.push(row);
      }

      return result;
    },
    getCellBackgroundColor(cell) {
      if (cell >= 0 && cell <= 9) {
        return '#E3E3E3';
      } else if (cell > 9 && cell <= 20) {
        return '#CCCCCC';
      } else if (cell > 20 && cell <= 30) {
        return '#E5C4C4';
      } else if (cell > 30 && cell <= 50) {
        return '#FFAFAF';
      } else if (cell > 50 && cell <= 100) {
        return '#FF5C5C';
      } else if (cell > 100 && cell <= 150) {
        return '#E60E0E';
      } else {
        return '#A60000';
      }
    },
    openCollect() {
      this.collectDialogVisible = true;
      this.statusList = [];
      this.step = 1
    },
    startMonitoring() {
      this.step = 1
      this.statusList = []
      this.$refs.collectRef.validate((valid) => {
        if (!valid) return
        this.isMonitoring = true
        this.playSound("人员请就位,听到睡姿指令后照做")
        if (this.mode !== "2") {
          this.addInterval()
        } else {
          this.playSound("居中，仰卧")
          this.intervalId = setInterval(() => {
            request.get('/sleep-position-collect/mattressStatus', {params: {bedId: this.CollectBaseData.bedId}}).then(res => {
              if (res.code === "0") {
                if(this.step>5){
                  clearInterval(this.intervalId);
                  this.updateStatus(this.step, 3)
                  this.playSound("采集结束")
                  this.isMonitoring = false
                  return
                }
                this.mattressStatus = res.data
                if ((this.befor_mattressStatus.tip === this.mattressStatus.tip) && (this.befor_mattressStatus.progress === this.mattressStatus.progress)) return

                if ((this.befor_mattressStatus.tip === "正在执行自动模式") && (this.mattressStatus.tip !== this.befor_mattressStatus.tip)) {
                  this.playSound("自动模式结束，保持当前睡姿，等待下一步指令")
                }
                if (((this.befor_mattressStatus.tip === "正在执行微调") && (this.mattressStatus.tip === "在线")) && (!this.waitCollect)) {
                  this.CollectBaseData.project = this.getRandomInt1_2()
                  this.CollectBaseData.actualSleepPosition = this.getRandomInt1_3()
                  this.playSound("第" + this.step + "次翻身")
                  this.playSound(this.modePlan[this.CollectBaseData.project])
                  this.playSound(this.modePlan[this.CollectBaseData.actualSleepPosition + 2])
                  if (this.intervalId) {
                    setTimeout(() => {
                      this.updateStatus(this.step, 0)
                      this.step++
                      setTimeout(() => {
                        this.collectData()
                      }, (this.CollectBaseData.period + 5) * 1000)
                    }, 10 * 1000)
                  }
                  this.waitCollect = true
                }
                const currentTime = new Date().toLocaleTimeString();
                this.statusList.unshift({
                  id: Date.now(),
                  status: this.mattressStatus.tip + " (" + this.mattressStatus.progress + "%)",
                  time: currentTime,
                  bedId: this.CollectBaseData.bedId,
                })
                this.befor_mattressStatus = this.mattressStatus
              }
            })
          }, 3 * 1000)
        }
      })
    },
    stopMonitoring() {
      console.log("clearInterval:" + this.intervalId)
      clearInterval(this.intervalId);
      this.isMonitoring = false;
      this.step = 1
    },
    addInterval() {
      this.intervalId = setInterval(() => {
        if (this.step > 1) {
          this.collectData()
        }
        if (this.step === 13) {
          clearInterval(this.intervalId)
          this.updateStatus(this.step, 3)
          this.playSound("采集结束")
          this.isMonitoring = false
          return
        }

        if (this.mode === "1") {
          this.CollectBaseData.project = Math.ceil(this.step / 3);
          this.CollectBaseData.actualSleepPosition = ((this.step - 1) % 3) + 1;
        } else if (this.mode === "0") {
          this.CollectBaseData.project = this.getRandomInt1_2()
          this.CollectBaseData.actualSleepPosition = this.getRandomInt1_3()
        }

        this.playSound("第" + this.step + "次")
        this.playSound(this.modePlan[this.CollectBaseData.project])
        this.playSound(this.modePlan[this.CollectBaseData.actualSleepPosition + 2])
        if (this.intervalId) {
          setTimeout(() => {
            this.updateStatus(this.step, 0)
            this.step++
          }, 10 * 1000)
        }
      }, (this.CollectBaseData.period + 15) * 1000)
    },
    collectData() {
      // 记录前一次数据
      request.post('/sleep-position-collect', this.CollectBaseData).then(res => {
        if (res.code === "0") {
          this.updateStatus(this.step - 1, 1);
        } else {
          clearInterval(this.intervalId);
          this.updateStatus(this.step - 1, 2);
          this.playSound("采集异常");
          this.isMonitoring = false;
        }
        this.waitCollect = false
      });
    },
    updateStatus(step, flag) {
      const currentTime = new Date().toLocaleTimeString();
      let status
      if (flag === 0) {
        status = "第" + step + "次开始采集/" + this.modePlan[this.CollectBaseData.project] + "/" + this.modePlan[this.CollectBaseData.actualSleepPosition + 2]
      } else if (flag === 1) {
        status = "第" + step + "次结束采集"
      } else if (flag === 2) {
        status = "第" + step + "次采集异常"
      } else {
        status = "当前轮次全部采集结束"
      }
      this.statusList.unshift({
        id: Date.now(),
        status,
        time: currentTime,
        bedId: this.CollectBaseData.bedId,
      })
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => (v.id))
    },
    handleSizeChange() {
      this.load()
    },
    handleCurrentChange() {
      this.load()
    },
    handleClose() {
      clearInterval(this.intervalId);
      done();
    }
  },
  beforeDestroy() {
    clearInterval(this.intervalId);
  }
}
</script>

<style scoped>

.fixed-box h3 {
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 1px black solid;
}

.status-item p {
  margin: 0;
}

button {
  padding: 8px 12px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  outline: none;
}

.header {
  display: flex;
  justify-content: center;
  margin-top: 10px;
}


.form-item {
  display: flex;
  flex-wrap: wrap;
}

.status-container {
  margin: 20px;
}

.fixed-box {
  position: sticky;
  padding: 15px;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  border-radius: 5px;
  display: flex;
  flex-direction: column;
}

.fixed-box h3 {
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 1px black solid;
}

.content {
  height: 300px;
  overflow: auto;
}

.status-item {
  margin-bottom: 15px;
}

.status-item p {
  margin: 0;
}

.status {
  font-weight: bold;
}

button {
  padding: 8px 12px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  outline: none;
}

.footer-btn {
  display: flex;
  justify-content: space-between;
  margin: 0 20px;
}

.grid {
  display: flex;
  flex-direction: column;
}

.row {
  display: flex;
}

.cell {
  width: 40px;
  height: 40px;
  border: 1px solid white;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>