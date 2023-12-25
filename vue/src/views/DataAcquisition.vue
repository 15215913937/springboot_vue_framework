<template>
  <div style="padding: 10px">
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
      <el-popconfirm title="确定要删除吗" @confirm="deleteBatch">
        <template #reference>
          <el-button class="mb-10" type="danger" style="float: right;margin-right: 10px"
                     v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
            <el-icon>
              <Delete/>
            </el-icon>
            &nbsp批量删除
          </el-button>
        </template>
      </el-popconfirm>

    </div>
    <el-table
        :data="tableData"
        border
        stripe
        style="width: 100%"
        highlight-current-row>

      <el-table-column type="selection" align="center"/>
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

      <el-table-column fixed="right" label="操作" width="150px" align="center">
        <template #default="scope">
          <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button type="danger" v-if="user.role==='ROLE_ADMIN' || user.role==='ROLE_USER'">
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
          v-model:current-page="page.currentPage"
          v-model:pageSize="page.pageSize"
          :page-sizes="[20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="page.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
      <el-dialog v-model="dialogVisible"
                 :title="title"
                 append-to-body>
        <div style="display: flex;flex-direction: row;width:100%">
          <div style="flex:1;text-align: center">
            <div class="grid">
              <div v-for="(row, rowIndex) in pressure2" :key="rowIndex" class="row">
                <div v-for="(cell, colIndex) in row" :key="colIndex" class="cell">{{ cell }}</div>
              </div>
            </div>
          </div>
          <div style="flex: 1;text-align: center">
            <img v-if="base64Data" :src="base64Data" alt="Image">
          </div>
        </div>
        <template #footer>
          <el-button @click="dialogVisible = false">关闭</el-button>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";
import {Search, Delete, Upload} from "@element-plus/icons-vue";

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
      dialogVisible: false,
      title: '',
      pressure: [],
      pressure2: [],
      base64Data: ''
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
  methods: {
    generateGridData(row) {
      // 生成你需要的格子数据的逻辑
      const flatArray = row; // 生成长度为 168 的一维数组
      const gridData = [];

      for (let rowIndex = 0; rowIndex < 21; rowIndex++) {
        const row = flatArray.slice(rowIndex * 8, (rowIndex + 1) * 8);
        gridData.push(row);
      }
      this.pressure = gridData
      console.log(this.pressure)
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
    showDialog(row) {
      const str = row.pressure;
      this.pressure = str.split(",").map(Number)
      // 获取对象的值数组
      const values = Object.values(this.pressure);
      // 转换为8列的二维数组
      for (let i = 0; i < values.length; i += 8) {
        this.pressure2.push(values.slice(i, i + 8));
      }

      this.title = row.code;
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
      this.dialogVisible = true;
    },
    handleDelete(row) {
      this.id = row.id;
      request.delete("/renhe-collect/" + this.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    deleteBatch() {
      if (!this.ids.length) {
        this.$message.warning("请选择要删除的数据");
        return
      }
      request.post("/renhe-collect/deleteBatch", this.ids).then(res => {
        if (res.code === '0') {
          this.$message.success("批量删除成功");
        } else {
          this.$message.error(res.msg)
        }
      }).finally(() => {
        this.load();
      })
    },
    handleSizeChange() {
      this.load()
    },
    handleCurrentChange() {
      this.load()
    }
  }
}
</script>

<style scoped>
.container {
  display: flex;
  align-items: center;
  /*justify-content: center;*/
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
  border: 1px solid black;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>