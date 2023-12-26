<template>
  <div class="main-header">
    <el-button class="mb-10" type="primary" @click="startCollect">开始采集</el-button>
    <div class="container">
      <el-input v-model="search.code" placeholder="请输入传感垫key" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-input v-model="search.bedId" placeholder="请输入采集床垫ID" style="width: 15%" class="mr-10" :prefix-icon="Search"
                clearable/>
      <el-select v-model="search.mat" style="width: 15%" class="mr-10" placeholder="选择舒适层" clearable>
        <el-option v-for="mat in mats" :key="mat.value" :label="mat.label" :value="mat.value"></el-option>
      </el-select>
      <el-input v-model="search.batch" placeholder="选择批次" style="width: 15%" :prefix-icon="Search" class="mr-10"
                clearable/>
      <el-select v-model="search.coefficient" style="width: 15%" class="mr-10" placeholder="选择系数" clearable>
        <el-option v-for="coefficient in coefficients" :key="coefficient.value" :label="coefficient.label"
                   :value="coefficient.value"></el-option>
      </el-select>
      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>

    </div>

    <el-table
        :data="tableData"
        border
        stripe
        style="width: 100%"
        highlight-current-row>

      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="code" label="传感垫key" align="center">
        <template #default="scope">
          <span>
            <el-button type="text" @click="showDialog(scope.row)">{{ scope.row.code }}</el-button>
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="bedId" label="采集床垫" align="center"/>
      <el-table-column prop="mat" label="舒适层" align="center"/>
      <el-table-column prop="batch" label="批次" align="center"/>
      <el-table-column prop="firstPressure" label="首次压力和" align="center"/>
      <el-table-column prop="finalPressure" label="最终压力和" align="center"/>
      <el-table-column prop="coefficient" label="系数" align="center"/>

      <el-pagination small layout="prev, pager, next" :total="50"/>
    </el-table>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:current-page="page.currentPage"
          v-model:pageSize="page.pageSize"
          :page-sizes="[20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="page.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <el-dialog v-model="startDialogVisible" append-to-body>

        <div style="display: flex; flex-direction: column; justify-content: space-between;">
          <div class="header">
            <el-form :model="CollectBaseData" :rules="rules" ref="data" label-width="120px">
              <div class="form-item">
                <el-form-item label="批次" prop="batch">
                  <el-input v-model="CollectBaseData.batch"/>
                </el-form-item>
                <el-form-item label="采集床垫ID" prop="bedId">
                  <el-input v-model="CollectBaseData.bedId"/>
                </el-form-item>
                <el-form-item label="舒适层" prop="mat">
                  <el-radio-group v-model="CollectBaseData.mat">
                    <el-radio label="stand"/>
                    <el-radio label="plus"/>
                    <el-radio label="pro"/>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="数据系数" prop="coefficient">
                  <el-radio-group v-model="CollectBaseData.coefficient">
                    <el-radio label="1"/>
                    <el-radio label="1.5"/>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="阈值" prop="threshold">
                  <el-input v-model="threshold"/>
                </el-form-item>
                <el-form-item label="确认时间" prop="confirmTime">
                  <el-radio-group v-model="confirmTime">
                    <el-radio label='6'/>
                    <el-radio label='12'/>
                    <el-radio label='24'/>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="硬件码key" prop="code">
                  <el-input v-model="CollectBaseData.code"/>
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
                  <p class="status">当前{{ this.CollectBaseData.bedId }}-{{ this.CollectBaseData.code }}压力总和:
                    {{ item.pressure }}</p>
                  <p class="time">时间: {{ item.time }}</p>
                </div>
              </div>
            </div>
          </div>
          <div class="footer-btn">
            <button @click="startMonitoring" v-if="!isMonitoring" class="start-btn">开始监测</button>
            <button @click="pauseMonitoring" v-else-if="!isPaused" class="pause-btn">暂停</button>
            <button @click="resumeMonitoring" v-else class="resume-btn">继续</button>
            <button @click="stopMonitoring" class="stop-btn">终止</button>
          </div>

        </div>
      </el-dialog>

      <el-dialog v-model="codeDataDialogVisible"
                 :title="title"
                 append-to-body>
        <div style="display: flex;justify-content: space-around;width:100%">
          <div style="display: flex;flex-direction:column;align-items: center">
            <div class="grid">
              <div v-for="(row, rowIndex) in pressure2" :key="rowIndex" class="row">
                <div v-for="(cell, colIndex) in row" :key="colIndex"
                     :style="{ width: `${WcellSize}px`, height: `${HcellSize}px` ,backgroundColor: getCellBackgroundColor(cell),color:fontColor}"
                     class="cell">{{
                    cell
                  }}
                </div>
              </div>
            </div>
          </div>
          <div style="display: flex;flex-direction:column;align-items: center">
            <img v-if="base64Data" :src="base64Data" alt="Image">
          </div>
        </div>
        <div style="margin-top:20px;display: flex; align-items: center; justify-content: center;">
          <el-icon @click="copyData(dataToCopy)" style="cursor: pointer;color: #409EFF">
            <DocumentCopy/>
          </el-icon>
          <span>&nbsp&nbsp采集时间：{{ createTime }}</span>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";
import {Search, Delete, Upload} from "@element-plus/icons-vue";
import axios from 'axios';

export default {
  name: "DataAcquisition",
  data() {
    return {
      search: {
        code: '',
        bedId: '',
        mat: '',
        batch: '',
        coefficient: ''
      },
      mats: [ // 可选项数组
        {value: 'pro', label: 'pro'},
        {value: 'plus', label: 'plus'},
        {value: 'stand', label: 'stand'}
      ],
      coefficients: [ // 可选项数组
        {value: '1.5', label: '1.5倍'},
        {value: '1', label: '1倍'}
      ],
      tableData: [],
      page: {
        currentPage: 1,
        pageSize: 20,
        total: '',
      },
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      codeDataDialogVisible: false,
      startDialogVisible: false,
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
        bedId: '',
        mat: 'plus',
        batch: '',
        coefficient: '1',
        code: '',
        firstPressure: '',
        finalPressure: ''
      },
      threshold: 500,
      confirmTime: '24',
      timeout: 6,
      count: 0,
      rules: {
        bedId: [
          {required: true, message: '床垫id不能为空', trigger: 'blur'}
        ],
        code: [
          {required: true, message: '传感垫key不能为空', trigger: 'blur'}
        ]
      },
      statusList: [],
      intervalId: null,
      isMonitoring: false,
      isPaused: false
    }
  },
  created() {
    this.load();
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
    copyData(dataToCopy) {
      navigator.clipboard.writeText(dataToCopy)
          .then(() => {
            this.$message.success("已成功复制数据");
            // 在这里可以添加任何你希望的成功复制的处理逻辑
          })
          .catch((error) => {
            this.$message.error("复制数据失败:", error)
            // 在这里可以添加任何你希望的复制失败的处理逻辑
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
    load() {
      request.get("/renhe-collect", {
        params: {
          pageNum: this.page.currentPage,
          pageSize: this.page.pageSize,
          code: this.search.code,
          bedId: this.search.bedId,
          mat: this.search.mat,
          batch: this.search.batch,
          coefficient: this.search.coefficient
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.page.total = res.data.total;
      });
    },
    reset() {
      this.search.code = '';
      this.search.bedId = '';
      this.search.mat = '';
      this.search.batch = '';
      this.search.coefficient = '';
      this.load();
    },
    startCollect() {
      this.startDialogVisible = true;
      this.statusList = [];
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

      this.title = row.code;
      this.createTime = '';
      this.createTime = row.createTime;
      request.get('/renhe-collect/hotmap', {
        params: {
          id: row.id,
          bedId: row.bedId,
          pressures: row.pressure
        }
      }).then(res => {
        if (res.code === '0') {
          this.base64Data = 'data:image/jpeg;base64,' + res.data;
        }
      });
      this.codeDataDialogVisible = true;
    },

    handleSizeChange() {
      this.load()
    },
    handleCurrentChange() {
      this.load()
    },
    startMonitoring() {
      this.$refs.data.validate((valid) => {
        if (valid) {
          console.log(this.CollectBaseData)
          this.isMonitoring = true;
          this.timeout = 6;
          this.intervalId = setInterval(() => {
            if (!this.isPaused) {
              if (this.count === 2) {
                this.count = 0;
                this.stopMonitoring();
              } else {
                this.updateStatus();
              }
            }
          }, this.timeout * 1000)
        }
      });
    },
    pauseMonitoring() {
      this.isPaused = true;
    },
    resumeMonitoring() {
      this.isPaused = false;
    },
    stopMonitoring() {
      this.isMonitoring = false;
      clearInterval(this.intervalId);

    },
    updateStatus() {
      const config = {
        params: {
          "bedId": this.CollectBaseData.bedId
        },
        headers: {
          'Content-Type': 'application/json',
          'Token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNzM1MTQyNDAwLCJpYXQiOjE3MDM1NzM2NTcsInVzZXJuYW1lIjoiYWRtaW4ifQ.yRWoi9tAeq_psXt1rS4NH00wYfSAj90f96y7XAPBrSs'
        }
      };
      axios.get('https://bedapi.test.cnzxa.cn/api/pro/bed', config)
          .then(res => {
            const data = res.data.data;
            const pressure = data.pressureList;
            const sortedData = pressure.sort((a, b) => b - a)
            const sum = sortedData.slice(0, 45).reduce((a, b) => a + b, 0);
            const currentTime = new Date().toLocaleTimeString();
            let status;
            if (data.online === "false") {
              status = "床垫离线"
            } else {
              if (sum <= this.threshold) {
                status = "等待中..."
              } else {
                if (this.count === 0) {
                  status = '保存首次数据'
                  this.timeout = Number(this.confirmTime)
                } else {
                  status = "保存最终数据"
                }
                this.count++
              }
            }
            this.statusList.unshift({
              id: Date.now(),
              pressure: sum,
              status: status,
              time: currentTime
            });
          })
          .catch(error => {
            console.error('Error:', error);
          });


      if (this.statusList.length > 10) {
        this.statusList.pop();
      }
    }
  },
  beforeDestroy() {
    clearInterval(this.intervalId);
  }
}
</script>

<style scoped>
.container {
  display: flex;
  align-items: center;
  margin: 10px 0;
  clear: both;
}

.container > * {
  margin-right: 10px;
  margin-bottom: 10px;
  align-self: flex-start;
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
  width: 100px;
  padding: 8px 12px;
  margin-right: 10px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  outline: none;
}

.footer-btn {
  display: flex;
  justify-content: flex-end;
  margin: 0 10px;
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