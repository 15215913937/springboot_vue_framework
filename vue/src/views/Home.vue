<template>
  <div style="padding: 25px;display: flex">
    <div style="flex:1">
      <!--          消费账单区-->
      <div style="flex: 1;display: flex;max-height:400px;flex-direction: column">
        <!--              @dblclick 双击事件-->
        <el-card style="width:95%" @dblclick="$router.push('/bill')">
          <div style="margin: 10px">
            <div style="font-size: 25px;margin-bottom: 20px;width: 50%">
              <el-icon>
                <WalletFilled/>
              </el-icon>
              我的账单
            </div>
          </div>
          <div style="margin: 10px;height: 120px;display: flex;flex-direction: column;width:100%">
            <div style="flex:1;display: flex;margin: 20px 0">
              <div style="flex: 1;text-align: left;font-size: 20px;width: 300px;height: 30px;">本月支出:&nbsp&nbsp<span
                  style="color:green">{{
                  billInfo.currentExpense
                }}</span>&nbsp<span style="font-size: 10px">{{ billInfo.expenseRatioYearOnYear }}</span>
              </div>
              <div style="flex: 1;text-align: left;font-size: 20px;width: 300px;height: 30px;">本月收入:&nbsp&nbsp<span
                  style="color: red">{{
                  billInfo.currentIncome
                }}</span>&nbsp<span style="font-size: 10px">{{ billInfo.incomeRatioYearOnYear }}</span>
              </div>
            </div>
            <div style="flex:1;display: flex;margin: 20px 0">
              <div style="flex: 1;text-align: left;font-size: 17px;width: 300px;height: 30px;">上月支出:&nbsp&nbsp&nbsp{{
                  billInfo.lastExpense
                }}
              </div>
              <div style="flex: 1;text-align: left;font-size: 17px;width: 300px;height: 30px;">上月收入:&nbsp&nbsp&nbsp{{
                  billInfo.lastIncome
                }}
              </div>
            </div>
          </div>
        </el-card>
      </div>
      <!--          消费图表区-->
      <div style="flex: 1;display: flex;flex-direction: column">
        <div style="height:40px;margin: 10px;text-align: center">
          <el-date-picker
              v-model="toYearLeft"
              type="year"
              placeholder="请选择年份"
              @change="searchYearLeft"
          />
        </div>
        <div id="billChart" style="height: 300px;margin:15px"/>
      </div>
    </div>

    <div style="flex: 1;display: flex;max-height:400px;flex-direction: column">
      <!--家庭信息统计区-->
      <div style="flex: 1;">
        <el-row :gutter="10" style="margin-bottom: 15px">
          <el-col :span="6">
            <el-card style="color: #E6A23C" @dblclick="$router.push('/user')">
              <div>
                <el-icon>
                  <HomeFilled/>
                </el-icon>
                家庭成员
              </div>
              <div class="number"><span>{{ commonInfo.usersCount }} 人</span></div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card style="color: #67C23A" @dblclick="$router.push('/book')">
              <div>
                <el-icon>
                  <Reading/>
                </el-icon>
                现藏有书籍
              </div>
              <div class="number"><span>{{ commonInfo.booksCount }} 本</span></div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card style="color: #67C23A" @dblclick="$router.push('/events')">
              <div>
                <el-icon>
                  <DataLine/>
                </el-icon>
                事件总数
              </div>
              <div class="number"><span>{{ commonInfo.eventsCount }} 件</span></div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card style="color: #67C23A" @dblclick="$router.push('/file')">
              <div>
                <el-icon>
                  <Files/>
                </el-icon>
                文件总数
              </div>
              <div class="number"><span>{{ commonInfo.filesCount }} 份</span></div>
            </el-card>
          </el-col>

        </el-row>
        <el-row :gutter="50">
          <el-col :span="12">
            <el-card style="color: #409EFF">
              <div>
                <el-icon>
                  <Reading/>
                </el-icon>
                你拥有的书籍
              </div>
              <div class="userNumber"><span>{{ commonInfo.myBookCount }} 本</span></div>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card style="color: #409EFF">
              <div>
                <el-icon>
                  <DataLine/>
                </el-icon>
                你的事件
              </div>
              <div class="userNumber"><span>{{ commonInfo.myEventCount }} 件</span></div>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <!--购书图表区-->
      <div style="flex: 1;display: flex;flex-direction: column">
        <div style="margin: 10px;text-align: center">
          <el-date-picker
              v-model="toYear"
              type="year"
              placeholder="请选择年份"
              @change="searchYear"
          />
        </div>
        <div style="margin: 15px">
          <el-row>
            <el-col :span="12">
              <div id="main" style="height: 300px"/>
            </el-col>
            <el-col :span="12">
              <div id="pie" style="height: 300px"/>
            </el-col>
          </el-row>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";
import * as echarts from 'echarts';

export default {
  name: "Home",

  data() {
    return {
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      billInfo: {
        lastExpense: null,
        incomeRatioYearOnYear: null,
        currentIncome: null,
        expenseRatioYearOnYear: null,
        lastIncome: null,
        currentExpense: null
      },
      commonInfo: {
        filesCount: null,
        myBookCount: null,
        usersCount: null,
        eventsCount: null,
        myEventCount: null,
        booksCount: null
      },
      total: 0,
      today: 0,
      extData: 0,
      toYearLeft: new Date(),
      toYear: new Date(),
      oneData1: [],
      oneData2: [],
      allData: [],
      billData: {
        income: [],
        outcome: []
      }
    }
  },
  created() {
    // 获取个人数据
    request.get("/home/getHomeOneInfo/" + this.user.id).then(res => {
      this.billInfo = res.data.billInfo;
      this.commonInfo = res.data.commonInfo;
    })

  },
  mounted() {
    this.searchYear(this.toYear);
    this.searchYearLeft(this.toYearLeft);
  },
  methods: {
    getChart3() {
      // 消费折线图
      let myChart3 = echarts.init(document.getElementById('billChart'));
      let option3 = {
        title: {
          text: '月消费趋势图',
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['支出', '收入']
        },
        xAxis: {
          axisLabel: {   //显示全部月份
            interval: 0
          },
          type: 'category',
          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            formatter: '{value} 元'
          }
        },
        series: [
          {
            name: '支出',
            data: this.billData.outcome,
            type: 'line'
          }, {
            name: '收入',
            data: this.billData.income,
            type: 'line'
          }
        ]
      };
      myChart3.setOption(option3);
    },
    getChart1() {
      // 折线图
      let myChart1 = echarts.init(document.getElementById('main'));
      let option1 = {
        // title: {
        //   text: '购书趋势图',
        // },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['总体购书趋势', '个人购书趋势']
        },
        xAxis: {
          axisLabel: {   //显示全部月份
            interval: 0
          },
          type: 'category',
          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        },
        yAxis: {
          minInterval: 1, //显示整数
          type: 'value',
          axisLabel: {
            formatter: '{value} 本'
          }
        },
        series: [
          {
            name: '总体购书趋势',
            data: this.allData,
            type: 'line'
          },
          {
            name: '个人购书趋势',
            data: this.oneData1,
            type: 'line'
          }
        ]
      };
      myChart1.setOption(option1);
    },
    getChart2() {
      // 饼图
      let myChart2 = echarts.init(document.getElementById('pie'));
      let option2 = {
        title: {
          text: '个人购书月比例图',
          left: 'center'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{b} <br/>{c}本  ({d}%)'
        },
        // legend: {
        //     top: '5%',
        //     left: 'center'
        // },
        series: [
          {
            // name: '总体每月购书',
            type: 'pie',
            radius: ['30%', '70%'],
            data: this.oneData2,
            emphasis: {
              label: {
                show: true,
                fontSize: '30',
                fontWeight: 'bold'
              }
            },
            label: {
              show: false,
              position: 'center'
            },
            labelLine: {
              show: false
            },
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            }
          },
        ]
      };
      myChart2.setOption(option2);
    },
    searchYear(n) {
      if (n === '') {
        n = this.toYear;
      }
      n = n.toString().split(' ');
      this.toYear = n[3];
      request.get("/echarts/booksPurchaseStatistics", {
        params: {
          year: this.toYear,
          id: this.user.id
        }
      }).then(res => {
            this.allData = res.data.all;
            this.oneData1 = res.data.one;
            for (let i = 0; i < res.data.one.length; i++) {
              this.oneData2[i] = {name: i + "月", value: res.data.one[i]};
            }
            this.getChart1();
            this.getChart2();
          }
      );
    },
    searchYearLeft(n) {
      if (n === '') {
        n = this.toYearLeft;
      }
      n = n.toString().split(' ');
      this.toYearLeft = n[3];
      request.get("/consumer-details/findById", {
        params: {
          year: this.toYearLeft,
          id: this.user.id
        }
      }).then(res => {
            this.billData.outcome = res.data.outcome;
            this.billData.income = res.data.income;
            this.getChart3();
          }
      );
    }
  }

}

</script>

<style scoped>
.number {
  padding: 10px 0;
  text-align: center;
  font-weight: bold;
  font-size: 15px

}

.userNumber {
  padding: 10px 0;
  text-align: center;
  font-weight: bold;
  font-size: 25px

}

</style>
