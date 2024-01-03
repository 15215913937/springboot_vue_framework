<template>
  <div class="main-header">
    <div class="mtb-10">
      <el-button type="primary" @click="openCollect">
        <el-icon>
          <VideoPlay/>
        </el-icon>
        &nbsp开始采集
      </el-button>
      <el-button type="warning" @click="exportImg">
        <el-icon>
          <Upload/>
        </el-icon>
        &nbsp导出图像
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
        <el-select v-model="search.project" class="mr-10" placeholder="测试项目" clearable>
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
      <el-table-column prop="name" label="测试者" align="center" width="80px">
      </el-table-column>
      <el-table-column prop="mat" label="舒适层" align="center" width="85px">
        <template #default="scope">
          <el-tag effect="plain" v-if="scope.row.mat===1">STAND</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.mat===2">PLUS</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.mat===3">PRO</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="project" label="测试项目" align="center">
        <template #default="scope">
          <el-tag effect="plain" v-if="scope.row.project===1">正中识别</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.project===2">1/3身体在传感器外(靠左)</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.project===3">1/3身体在传感器外(靠右)</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="isAutomode" label="自动模式" align="center" width="85px">
        <template #default="scope">
          <el-tag effect="plain" type="success" v-if="scope.row.isAutomode">开启</el-tag>
          <el-tag effect="plain" type="danger" v-else>关闭</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="isFineAdjustment" label="微调" align="center" width="70px">
        <template #default="scope">
          <el-tag effect="plain" type="success" v-if="scope.row.isFineAdjustment">开启</el-tag>
          <el-tag effect="plain" type="danger" v-else>关闭</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="period" label="间隔" align="center" width="70px"/>

      <el-table-column prop="actualSleepPosition" label="实际睡姿" align="center">
        <template #default="scope">
          <el-tag effect="plain" type="danger" v-if="scope.row.actualSleepPosition===5">无人</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===1">仰卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===2">左侧卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===3">右侧卧</el-tag>
          <el-tag effect="plain" v-else>坐姿</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="recognition" label="识别睡姿" align="center">
        <template #default="scope">
          <el-tag effect="plain" type="danger" v-if="scope.row.recognition===5">无人</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===1">仰卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===2||scope.row.recognition===3">侧卧</el-tag>
          <el-tag effect="plain" v-else-if="scope.row.recognition===4">坐姿</el-tag>
          <el-tag effect="plain" v-else type="info">未知</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="isReg" label="结果" align="center">
        <template #default="scope">
          <el-tag effect="dark" type="success" v-if="scope.row.isReg===0">识别成功</el-tag>
          <el-tag effect="dark" type="danger" v-if="scope.row.isReg===1">识别失败</el-tag>
          <el-tag effect="dark" type="info" v-else>未识别</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="startTime" label="开始时间" align="center"/>

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
      <el-dialog v-model="collectDialogVisible" append-to-body>
        <div style="display: flex; flex-direction: column; justify-content: space-between;">
          <div class="header">
            <el-form :model="CollectBaseData" :rules="collectRules" ref="collectRef" label-width="120px">
              <div class="form-item">
                <el-form-item label="测试人" prop="name">
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
                <el-form-item label="舒适层" prop="mat">
                  <el-radio-group v-model="CollectBaseData.mat">
                    <el-radio label="1">STAND</el-radio>
                    <el-radio label="2">PLUS</el-radio>
                    <el-radio label="3">PRO</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="自动模式" prop="isAutomode">
                  <el-radio-group v-model="CollectBaseData.isAutomode">
                    <el-radio label="true">开</el-radio>
                    <el-radio label="false">关</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="微调" prop="isFineAdjustment">
                  <el-radio-group v-model="CollectBaseData.isFineAdjustment">
                    <el-radio label="true">开</el-radio>
                    <el-radio label="false">关</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="监测周期(秒)" prop="period">
                  <el-input-number v-model="CollectBaseData.period" :step="10" min="0"/>
                </el-form-item>
                <el-form-item label="采集方式" prop="mode">
                  <el-radio-group v-model="mode">
                    <el-radio label="1">顺序</el-radio>
                    <el-radio label="0">随机</el-radio>
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
            <button @click="startMonitoring" v-if="!isMonitoring" class="start-btn">开始监测</button>
            <button @click="pauseMonitoring" v-else-if="!isPaused" class="pause-btn">暂停</button>
            <button @click="resumeMonitoring" v-else class="resume-btn">继续</button>
            <button @click="stopMonitoring('已终止')" v-if="isMonitoring" class="stop-btn">终止</button>
          </div>
        </div>
      </el-dialog>
    </div>
  </div>

</template>

<script>
import request from "../utils/request";
import {Search, Delete, Upload} from "@element-plus/icons-vue";
import axios from 'axios';
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
        {value: 1, label: 'stand'},
        {value: 2, label: 'plus'},
        {value: 3, label: 'pro'},
      ],
      sleepPositions: [
        {value: 1, label: '仰卧'},
        {value: 2, label: '左侧卧'},
        {value: 3, label: '右侧卧'},
        {value: 4, label: '坐姿'},
        {value: 5, label: '无人'}
      ],
      projects: [
        {value: 1, label: '正中识别'},
        {value: 2, label: '1/3身体在传感器外识别'}
      ],
      res: [
        {value: 0, label: '未识别'},
        {value: 1, label: '识别成功'}
      ],
      names: [],
      tableData: [],
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      codeDataDialogVisible: false,
      collectDialogVisible: false,
      createTime: '',
      title: '',
      pressure: [],
      pressure2: [],
      base64Data: '',
      WcellSize: 35,
      HcellSize: 25,
      fontColor: '#000000',
      dataToCopy: '',
      CollectBaseData: {
        userInfoId: '',
        bedId: '1457',
        mat: "2",
        period: 30,
        isAutomode: "true",
        isFineAdjustment: "true",
        actualSleepPosition: 1,
        project: 1,
        startTime: ''
      },
      mode: "1",
      modePlan: {
        1: "正中",
        2: "1/3身体在传感器外(偏左)",
        3: "1/3身体在传感器外(偏右)",
        4: "仰卧",
        5: "左侧卧",
        6: "右侧卧"
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
      isPaused: false,
      ids: []
    }
  },
  created() {
    this.load();
    request.get('/user-info/all').then(res => {
      this.names = res.data
    })
  },
  setup() {
    return {
      Search,
      Delete,
      Upload
    }
  },
  computed: {
    latestStatus() {
      return this.statusList.slice(0, 10);
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
    copyData(dataToCopy) {
      navigator.clipboard.writeText(dataToCopy)
          .then(() => {
            this.$message.success("已成功复制数据");
          })
          .catch((error) => {
            this.$message.error("复制数据失败:", error)
          });
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
    getRandomInt1_3() {
      return Math.floor(Math.random() * 3) + 1
    },
    showDialog(row) {
      this.dataToCopy = '';
      this.dataToCopy = row.pressure;
      const str = row.pressure;
      this.pressure2 = []
      this.pressure = str.split(",").map(Number)
      // 获取对象的值数组
      const values = Object.values(this.pressure);
      // 转换为8列的二维数组
      for (let i = 0; i < values.length; i += 8) {
        this.pressure2.push(values.slice(i, i + 8));
      }
      request.get('/renhe-collect/hotmap', {
            params: {
              pressure: row.pressure,
              bedId: row.bedId
            }
          }
      ).then(res => {
        this.base64Data = 'data:image/jpeg;base64,' + res.data;
      })
      this.title = row.code;
      this.createTime = row.createTime;
      this.codeDataDialogVisible = true;
    },
    openCollect() {
      this.collectDialogVisible = true;
      this.statusList = [];
      this.step = 1
    },
    startMonitoring() {
      this.isMonitoring = true
      this.$refs.collectRef.validate((valid) => {
        if (!valid) return
        this.playSound("人员请就位")
        this.playSound("5")
        this.playSound("4")
        this.playSound("3")
        this.playSound("2")
        this.playSound("1")
        this.playSound("开始")
        // 约10秒语音时长+准备时长
        setTimeout(() => {
          this.addInterval()
        }, (this.CollectBaseData.period + 10) * 1000)
      })
    },
    stopMonitoring() {
      clearInterval(this.intervalId);
      this.isMonitoring = false;
      this.step = 1
    }
    ,
    pauseMonitoring() {
      clearInterval(this.intervalId)
      this.isPaused = true;
    }
    ,
    resumeMonitoring() {
      this.isPaused = false;
      this.startMonitoring()
    },
    addInterval() {
      this.intervalId = setInterval(() => {
        if (this.step === 13) {
          clearInterval(this.intervalId)
          this.updateStatus(this.step)
          this.playSound("采集结束")
          this.isMonitoring = false
          return
        }

        if (this.mode === "1") {
          this.CollectBaseData.project = Math.ceil(this.step / 4);
          this.CollectBaseData.actualSleepPosition = ((this.step - 1) % 3) + 1;
        } else if (this.mode === "0") {
          this.CollectBaseData.project = this.getRandomInt1_3()
          this.CollectBaseData.actualSleepPosition = this.getRandomInt1_3()
        }
        if (this.step > 1) {
          console.log("记录结束识别压力")
          request.get('//sleep-position-collect')
        }
        this.playSound("第" + this.step + "次")
        this.playSound(this.modePlan[this.CollectBaseData.project])
        this.playSound(this.modePlan[this.CollectBaseData.actualSleepPosition + 3])
        setTimeout(() => {
          this.updateStatus(this.step)
          // 记录当前数据...
          this.CollectBaseData.startTime = this.getLocalTime()
          request.post('/sleep-position-collect', this.CollectBaseData)
          this.step++
        }, 10 * 1000)

      }, (this.CollectBaseData.period + 10) * 1000)
    },
    updateStatus(step) {
      try {
        const currentTime = new Date().toLocaleTimeString();
        let status
        if (this.step === 13) return
        status = "第" + step + "次已采集"
        this.statusList.unshift({
          id: Date.now(),
          status,
          time: currentTime,
          bedId: this.CollectBaseData.bedId,
        });
      } catch (error) {
        console.error('Error:', error);
      }
    },
    getLocalTime() {
      let currentDate = new Date();
      return moment(currentDate).format('YYYY-MM-DD HH:mm:ss');
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => (v.id))
    },
    exportImg() {
      if (this.ids.length === 0) {
        this.$message.info("请选择至少一条记录")
      } else {
        request.post('/renhe-collect/exportPressureAndHotImg', this.ids).then(res => {
          if (res.code === '0') {
            this.$message.success('导出成功,文件已保存到 ' + res.data)
          } else {
            this.$message.error("导出失败，请重试！")
          }
        })
      }
    }
    ,
    handleSizeChange() {
      this.load()
    }
    ,
    handleCurrentChange() {
      this.load()
    }
  }
  ,
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

.start-btn {
  background-color: #4CAF50;
  color: white;
}

.pause-btn {
  background-color: #FF9800;
  color: white;
}

.resume-btn {
  background-color: #2196F3;
  color: white;
}

.stop-btn {
  background-color: #F44336;
  color: white;
}
</style>