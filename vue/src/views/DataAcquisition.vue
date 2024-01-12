<template>
  <div class="main-header">
    <div class="mtb-10">
      <el-button type="primary" @click="startCollect">
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
        <el-input v-model="search.code" placeholder="传感垫key" class="mr-10" :prefix-icon="Search"
                  clearable/>
        <el-input v-model="search.bedId" placeholder="采集床垫ID" class="mr-10" :prefix-icon="Search"
                  clearable/>
        <el-select v-model="search.mat" class="mr-10" placeholder="选择舒适层" clearable>
          <el-option v-for="mat in mats" :key="mat.value" :label="mat.label" :value="mat.value"></el-option>
        </el-select>
        <el-select v-model="search.status" class="mr-10" placeholder="是否合格" clearable>
          <el-option v-for="s in status" :key="s.value" :label="s.label" :value="s.value"></el-option>
        </el-select>
        <el-input v-model="search.batch" placeholder="批次" :prefix-icon="Search" class="mr-10"
                  clearable/>
        <el-select v-model="search.coefficient" class="mr-10" placeholder="选择系数" clearable>
          <el-option v-for="coefficient in coefficients" :key="coefficient.value" :label="coefficient.label"
                     :value="coefficient.value"></el-option>
        </el-select>
        <el-select v-model="search.position" class="mr-10" placeholder="姿势" clearable>
          <el-option v-for="p in positions" :key="p.value" :label="p.label" :value="p.value"></el-option>
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
        style="width: 100%"
        highlight-current-row
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="40px" align="center"/>
      <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
      <el-table-column prop="code" sortable label="传感垫key" align="center">
        <template #default="scope">
          <span>
            <el-button style="font-size: large" type="text" @click="showDialog(scope.row)">{{
                scope.row.code
              }}</el-button>
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="bedId" label="采集床垫" align="center"/>
      <el-table-column prop="mat" label="舒适层" align="center" width="70px"/>
      <el-table-column prop="batch" label="批次" align="center" width="70px"/>
      <el-table-column prop="coefficient" label="系数" align="center" width="70px"/>
      <el-table-column prop="firstPressure" label="首次压力和" align="center"/>
      <el-table-column prop="finalPressure" label="最终压力和" align="center" sortable/>
      <el-table-column prop="position" label="姿势" align="center">
        <template #default="scope">
          <el-tag type="warning" v-if="scope.row.position === 'IDLE'">无人</el-tag>
          <el-tag type="success" v-else-if="scope.row.position==='SIT'">坐姿</el-tag>
          <el-tag v-else>睡姿</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" align="center">
        <template #default="scope">
          <el-button v-if="scope.row.status === 0" type="info" @click="toCheck(scope.row)">待审核</el-button>
          <el-tag effect="dark" type="success" v-else-if="scope.row.status===1">合格</el-tag>
          <el-tag effect="dark" type="danger" v-else>不合格</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="remarks" label="备注" align="center">
        <template #default="scope">
          <el-button @click="editRemark(scope.row)">
            <el-icon>
              <Edit/>
            </el-icon>
          </el-button>
          <span>&nbsp{{ scope.row.remarks }}</span>
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
                  <el-input-number v-model="threshold" :step="50" min="0"/>
                </el-form-item>
                <el-form-item label="确认时间" prop="confirmTime">
                  <el-radio-group v-model="confirmTime">
                    <el-radio label='10'/>
                    <el-radio label='20'/>
                    <el-radio label='30'/>
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
                  <p class="status">当前{{ item.bedId }}-{{ item.code }}压力总和:
                    {{ item.pressure }}</p>
                  <p class="time">时间: {{ item.time }}</p>
                </div>
              </div>
            </div>
          </div>
          <div class="footer-btn">
            <button @click="startMonitoring" v-if="!isMonitoring" class="start-btn">开始监测
            </button>
            <button @click="stopMonitoring('已终止')" v-if="isMonitoring" class="stop-btn">终止</button>
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
            <img v-if="base64Data" :src="base64Data" alt="Image" @load="imageLoaded = true">
          </div>
        </div>
        <div style="margin-top:20px;display: flex; align-items: center; justify-content: center;">
          <el-icon @click="copyData(dataToCopy)" style="cursor: pointer;color: #409EFF">
            <DocumentCopy/>
          </el-icon>
          <span>&nbsp&nbsp采集时间：{{ createTime }}</span>
        </div>
      </el-dialog>
      <el-dialog
          title="审核"
          v-model="checkDialogVisible"
          append-to-body
          width="400px"
      >
        <div style="display: flex;flex-direction: column;">
          <div style="height: 30px;display: flex;align-items: center;justify-content: center;margin-bottom:20px">
            <el-radio-group v-model="checkOperation.status">
              <div style="width: 400px;display: flex;justify-content: space-between;padding:0 20px">
                <el-radio style="width: 45%" label="1" size="large" border>合格</el-radio>
                <el-radio style="width: 45%" label="2" size="large" border>不合格</el-radio>
              </div>
            </el-radio-group>
          </div>
          <div style="flex: 1;display: flex;align-items: center;justify-content: center;">
            <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入备注"
                maxlength="100"
                show-word-limit
                v-model="checkOperation.remarks"
            ></el-input>
          </div>
          <div style="height: 30px;display: flex;justify-content: flex-end;margin-top:20px">
            <el-button type="primary" @click="saveSelect">确认</el-button>
          </div>
        </div>
      </el-dialog>
      <el-dialog
          title="备注"
          v-model="remarkDialogVisible"
          append-to-body
          width="400px"
      >
        <div style="display: flex;flex-direction: column;">
          <div style="flex: 1;display: flex;align-items: center;justify-content: center;">
            <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入备注"
                maxlength="100"
                show-word-limit
                v-model="checkOperation.remarks"
            ></el-input>
          </div>
          <div style="height: 30px;display: flex;justify-content: flex-end;margin-top:20px">
            <el-button type="primary" @click="saveRemark()">确认</el-button>
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

export default {
  name: "DataAcquisition",
  data() {
    return {
      search: {
        code: '',
        bedId: '',
        mat: '',
        batch: '',
        coefficient: '',
        status: '',
        position: '',
        pageNum: 1,
        pageSize: 20,
        total: '',
      },
      mats: [
        {value: 'pro', label: 'pro'},
        {value: 'plus', label: 'plus'},
        {value: 'stand', label: 'stand'}
      ],
      coefficients: [
        {value: '1.5', label: '1.5倍'},
        {value: '1', label: '1倍'}
      ],
      tableData: [],
      status: [
        {value: '0', label: '待审核'},
        {value: '1', label: '合格'},
        {value: '2', label: '不合格'}
      ],
      positions: [
        {value: 'IDLE', label: '无人'},
        {value: 'SIT', label: '坐姿'},
        {value: 'SUPINE', label: '睡姿'}
      ],
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
        bedId: '1457',
        mat: 'plus',
        batch: '',
        coefficient: '1',
        code: '',
        firstPressure: null
      },
      threshold: 600,
      confirmTime: '30',
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
      is_err: 0,
      rows: [],
      checkDialogVisible: false,
      checkOperation: {
        id: null,
        status: '',
        remarks: ""
      },
      info: '',
      remarkDialogVisible: false,
      pressureApiData: {},
      timeOutId: null
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
    toCheck(data) {
      this.checkDialogVisible = true
      this.checkOperation = {
        id: data.id,
        status: '',
        remarks: data.remarks
      }
    },
    saveSelect() {
      if (this.checkOperation.status === '') {
        this.$message.error("请选择审核结果")
        return
      }
      request.post("/renhe-collect/check", this.checkOperation).then(res => {
        if (res.code === '0') {
          this.load()
          this.$message.success("审批成功")
          this.checkDialogVisible = false;

        } else {
          this.$message.error("审批失败")
        }
      })
    },
    playSound(text) {
      const synthesis = window.speechSynthesis;
      const utterance = new SpeechSynthesisUtterance(text); // 使用参数a作为语音内容
      utterance.rate = 1; // 将语速设置为1秒
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
    load() {
      request.get("/renhe-collect", {
        params: {
          code: this.search.code,
          bedId: this.search.bedId,
          mat: this.search.mat,
          batch: this.search.batch,
          coefficient: this.search.coefficient,
          status: this.search.status,
          position: this.search.position,
          pageNum: this.search.pageNum,
          pageSize: this.search.pageSize,
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.search.total = res.data.total;
      });
    },
    reset() {
      this.search = {}
      this.load();
    },
    editRemark(data) {
      this.remarkDialogVisible = true
      this.checkOperation.remarks = data.remarks
      this.checkOperation.id = data.id
    },
    saveRemark() {
      request.post("/renhe-collect/saveRemark/" + this.checkOperation.id, this.checkOperation.remarks).then(res => {
        if (res.code === '0') {
          this.load()
          this.$message.success("编辑成功")
          this.remarkDialogVisible = false;
        } else {
          this.$message.error("编辑失败")
        }
      })
    },
    startCollect() {
      this.startDialogVisible = true;
      this.statusList = [];
    },
    showDialog(row) {
      this.dataToCopy = row.pressure;
      this.pressure = row.pressure.split(",").map(Number);

      // 创建一个新的二维数组 pressure2，包含每8个元素的子数组
      this.pressure2 = [];
      for (let i = 0; i < this.pressure.length; i += 8) {
        this.pressure2.push(this.pressure.slice(i, i + 8));
      }

      request.get('/renhe-collect/hotmap', {
        params: {
          id: row.id,
          pressure: row.pressure,
          bedId: row.bedId
        }
      })
          .then(res => {
            this.base64Data = 'data:image/jpeg;base64,' + res.data;
          });

      this.title = row.code;
      this.createTime = row.createTime;
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
          this.isMonitoring = true
          this.count = 0
          this.is_err = 0
          this.timeout = 6
          this.setupInterval()
        }
      });
    },
    setupInterval() {
      clearInterval(this.intervalId); // 清除之前的计时器
      this.intervalId = setInterval(() => {
        if (this.count === 2) {
          this.stopMonitoring('采集结束');
        } else if (this.is_err === 1) {
          this.stopMonitoring('采集异常');
        } else {
          this.updateStatus();
        }
      }, this.timeout * 1000);
    },
    stopMonitoring(sound) {
      clearInterval(this.intervalId)
      clearInterval(this.timeOutId)
      this.playSound(this.CollectBaseData.code + sound);
      this.isMonitoring = false
      this.CollectBaseData.code = ''
    },
    async getPressureApiData(bedId) {
      this.pressureApiData = {};
      try {
        const res = await request.get('/renhe-collect/getPressure', {
          params: {
            bedId: bedId
          }
        });
        if (res.code === '0') {
          this.pressureApiData = {
            "pressure": res.data.pressure,
            "online": res.data.online,
            "fiducial_value": parseInt(res.data.fiducial_value)
          };
        }
      } catch (error) {
        console.error(error)
        this.pressureApiData = {};
      }
    },
    async updateStatus() {
      await this.getPressureApiData(this.CollectBaseData.bedId);
      console.log(this.pressureApiData)
      const currentTime = new Date().toLocaleTimeString();
      let bedId;
      let code;
      bedId = this.CollectBaseData.bedId;
      code = this.CollectBaseData.code;
      if (this.pressureApiData.online === 'false') {
        this.statusList.unshift({
          id: Date.now(),
          pressure: "",
          status: '床垫离线',
          time: currentTime,
          bedId,
          code,
        });
        this.stopMonitoring("床垫离线")
      } else {
        if (this.pressureApiData.fiducial_value < this.threshold) {
          this.statusList.unshift({
            id: Date.now(),
            pressure: this.pressureApiData.fiducial_value,
            status: '等待中...',
            time: currentTime,
            bedId,
            code,
          });
        } else {
          this.statusList.unshift({
            id: Date.now(),
            pressure: this.pressureApiData.fiducial_value,
            status: '首次出现压力',
            time: currentTime,
            bedId,
            code,
          });
          this.CollectBaseData.firstPressure = this.pressureApiData.fiducial_value
          clearInterval(this.intervalId)
          this.timeOutId = setTimeout(() => {
            const currentTime = new Date().toLocaleTimeString();
            this.getPressureApiData(bedId)
            if (this.pressureApiData.online === "false") {
              this.statusList.unshift({
                id: Date.now(),
                pressure: "",
                status: '床垫离线',
                time: currentTime,
                bedId,
                code,
              });
              this.stopMonitoring("床垫离线")
            } else {
              request.post('/renhe-collect/saveCollectData', this.CollectBaseData).then(res => {
                if (res.code === '0') {
                  this.stopMonitoring("采集结束")
                  this.statusList.unshift({
                    id: Date.now(),
                    pressure: this.pressureApiData.fiducial_value,
                    status: "数据保存成功",
                    time: currentTime,
                    bedId,
                    code,
                  });
                } else {
                  this.stopMonitoring("数据保存异常")
                }
              })
            }
          }, this.confirmTime * 1000)
        }
      }
    },
    handleSelectionChange(val) {
      this.rows = val.map(v => ({id: v.id, bedId: v.bedId, code: v.code, pressure: v.pressure, batch: v.batch}))
    },
    deleteBatch() {
      if (!this.rows.length) {
        this.$message.warning("请选择要删除的记录");
        return
      }
      const ids = []
      for (const r of this.rows) {
        ids.push(r.id)
      }
      request.post("/renhe-collect/deleteBatch", ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功");
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    async exportImg() {
      if (this.rows.length === 0) {
        this.$message.info("请选择至少一条记录")
      } else {
        try {
          const res = await request.post('/renhe-collect/exportPressureAndHotImg', this.rows);
          if (res.code === '0') {
            this.$message.success('导出成功,文件已保存到 ' + res.data)
          } else {
            this.$message.error("导出失败，请重试！")
          }
        } catch (error) {
          console.error(error);
          this.$message.error("导出失败，请重试！")
        }
      }
    },
  }
  ,
  beforeDestroy() {
    clearInterval(this.intervalId);
  }
}
</script>

<style scoped>

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