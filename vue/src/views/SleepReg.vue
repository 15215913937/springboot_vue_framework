<template>
  <div class="main-header">
    <div class="mb-10">
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
      <div style="display: flex">
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

        <div style="display: flex;align-content: flex-end">
          <el-button class="mb-10" type="primary" @click="load">查询</el-button>
          <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
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
        <el-table-column prop="mat" label="舒适层" align="center" width="80px">
          <template #default="scope">
            <el-tag effect="plain" v-if="scope.row.mat===1">stand</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.mat===2">plus</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.mat===3">pro</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="project" label="测试项目" align="center">
          <template #default="scope">
            <el-tag effect="plain" v-if="scope.row.project===1">正中识别</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.project===2">1/3身体在传感器外</el-tag>
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
            <el-tag effect="plain" type="danger" v-if="scope.row.actualSleepPosition===0">无人</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===1">仰卧</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===2">侧卧</el-tag>
            <el-tag effect="plain" v-else>坐姿</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="recognition" label="识别睡姿" align="center">
          <template #default="scope">
            <el-tag effect="plain" type="danger" v-if="scope.row.actualSleepPosition===0">无人</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===1">仰卧</el-tag>
            <el-tag effect="plain" v-else-if="scope.row.actualSleepPosition===2">侧卧</el-tag>
            <el-tag effect="plain" v-else>坐姿</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="isReg" label="结果" align="center">
          <template #default="scope">
            <el-tag effect="dark" type="success" v-if="scope.row.isReg===0">识别成功</el-tag>
            <el-tag effect="dark" type="danger" v-else>未识别</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" align="center"/>

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
      </div>

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
        {value: 0, label: '无人'},
        {value: 1, label: '仰卧'},
        {value: 2, label: '侧卧'},
        {value: 3, label: '坐姿'}
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
        firstPressure: null,
        finalPressure: null,
        pressure: []
      },
      threshold: 600,
      confirmTime: '24',
      timeout: 6,
      count: 0,
      rules: {
        code: [
          {required: true, message: '传感垫key不能为空', trigger: 'blur'}
        ]
      },
      statusList: [],
      intervalId: null,
      isMonitoring: false,
      isPaused: false,
      is_err: 0,
      ids: []
    }
  },
  created() {
    this.load();
    request.get('/user-info/all').then(res => {
      console.log(res.data);
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
      console.log(this.search)
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
    playSound(text) {
      const synthesis = window.speechSynthesis;
      const utterance = new SpeechSynthesisUtterance(text); // 使用参数a作为语音内容

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
    pauseMonitoring() {
      this.isPaused = true;
    },
    resumeMonitoring() {
      this.isPaused = false;
    },
    stopMonitoring(sound) {
      clearInterval(this.intervalId);
      this.playSound(this.CollectBaseData.code + sound);
      this.isMonitoring = false;
      this.is_err = 0
      this.timeout = 6
      this.count = 0
      this.CollectBaseData.code = '';


    },
    async updateStatus() {
      try {
        const config = {
          params: {
            bedId: this.CollectBaseData.bedId,
          },
          headers: {
            'Content-Type': 'application/json',
            Token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNzM1MjI4ODAwLCJpYXQiOjE3MDM2NDIzODksInVzZXJuYW1lIjoiYWRtaW4ifQ.y-QS527gOeg4p4kUVKbsx58Acg-l28uiUA_u1GJynqI',
          },
        };

        const res = await axios.get('https://bedapi.test.cnzxa.cn/api/pro/bed', config);
        const data = res.data.data;
        const pressure = data.pressureList;
        const finalPressure = [...res.data.data.pressureList];
        const sortedData = pressure.sort((a, b) => b - a);
        const sum = sortedData.slice(0, 45).reduce((a, b) => a + b, 0);
        const currentTime = new Date().toLocaleTimeString();

        let status;
        let bedId;
        let code;
        bedId = this.CollectBaseData.bedId;
        code = this.CollectBaseData.code;

        if (data.online === 'false') {
          status = '床垫离线';
          this.is_err = 1;
        } else {
          if (sum < this.threshold) {
            status = '等待中...';
          } else {
            if (this.count === 0) {
              this.CollectBaseData.firstPressure = sum;
              const res = await request.post('/renhe-collect/saveFirstPressure', this.CollectBaseData);
              if (res.code === '0') {
                status = '保存首次数据';
                this.timeout = Number(this.confirmTime);
                this.count++;
              } else {
                status = '首次存储异常';
                this.is_err = 1;
              }
              this.setupInterval();
            } else {
              this.CollectBaseData.finalPressure = sum;
              this.CollectBaseData.pressure = finalPressure;
              const res = await request.post('/renhe-collect/saveFinalPressure', this.CollectBaseData);
              if (res.code === '0') {
                status = '保存最终数据';
                this.count = 2;
              } else {
                status = '最终存储异常';
                this.is_err = 1;
              }
            }
          }
        }

        this.statusList.unshift({
          id: Date.now(),
          pressure: sum,
          status,
          time: currentTime,
          bedId,
          code,
        });
      } catch (error) {
        console.error('Error:', error);
        this.is_err = 1;
      }
    },
    handleSelectionChange(val) {
      this.ids = val.map(v => ({bedId: v.bedId, code: v.code, pressure: v.pressure, batch: v.batch}))
    },
    exportImg() {
      if (this.ids.length === 0) {
        this.$message.info("请选择至少一条记录")
      } else {
        console.log(this.ids)
        request.post('/renhe-collect/exportPressureAndHotImg', this.ids).then(res => {
          if (res.code === '0') {
            this.$message.success('导出成功,文件已保存到 ' + res.data)
          } else {
            this.$message.error("导出失败，请重试！")
          }
        })
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
  flex-direction: column;
}

.container > * {
  margin-bottom: 10px;
  align-self: flex-start;
}

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


</style>