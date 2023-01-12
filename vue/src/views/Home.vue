<template>
  <div style="padding: 25px;display: flex">
    <div style="flex:1">
      <!--          消费账单区-->
      <div style="flex: 1;display: flex;max-height:400px">
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
              <div style="flex: 1;text-align: left;font-size: 20px">本月支出:&nbsp&nbsp<span
                  style="color:green">{{
                  currentMonthExpense
                }}</span>&nbsp<span style="font-size: 10px">{{ expenseRatioYearOnYear }}</span>
              </div>
              <div style="flex: 1;text-align: left;font-size: 20px">本月收入:&nbsp&nbsp<span
                  style="color: red">{{
                  currentMonthIncome
                }}</span>&nbsp<span style="font-size: 10px">{{ incomeRatioYearOnYear }}</span>
              </div>
            </div>
            <div style="flex:1;display: flex;margin: 20px 0">
              <div style="flex: 1;text-align: left;font-size: 17px">上月支出:&nbsp&nbsp&nbsp{{
                  lastMonthExpense
                }}
              </div>
              <div style="flex: 1;text-align: left;font-size: 17px">上月收入:&nbsp&nbsp&nbsp{{
                  lastMonthIncome
                }}
              </div>
            </div>
          </div>
        </el-card>
      </div>
      <!--          消费图表区-->
      <div style="flex: 1">
        消费图表区
      </div>
    </div>

    <div style="flex: 1;display: flex;flex-direction: column">
      <!--家庭信息统计区-->
      <div style="flex: 1">
        <el-row :gutter="10" style="margin-bottom: 15px">
          <el-col :span="6">
            <el-card style="color: #E6A23C" @dblclick="$router.push('/user')">
              <div>
                <el-icon>
                  <HomeFilled/>
                </el-icon>
                家庭成员
              </div>
              <div class="number"><span>{{ userCount }} 人</span></div>
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
              <div class="number"><span>{{ bookCount }} 本</span></div>
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
              <div class="number"><span>{{ eventCount }} 件</span></div>
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
              <div class="number"><span>{{ fileCount }} 份</span></div>
            </el-card>
          </el-col>

        </el-row>
        <el-row :gutter="50" style="margin-bottom: 20px">
          <el-col :span="12">
            <el-card style="color: #409EFF">
              <div>
                <el-icon>
                  <Reading/>
                </el-icon>
                你拥有的书籍
              </div>
              <div class="userNumber"><span>{{ myBookCount }} 本</span></div>
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
              <div class="userNumber"><span>{{ myEventCount }} 件</span></div>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <!--          购书图表区-->
      <div style="flex: 1">
        <el-date-picker
            v-model="year"
            type="year"
            placeholder="请选择年份"
            @change="searchYear"
        />
        <el-row style="margin-top: 30px">
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
</template>

<script>
import request from "../utils/request";
import * as echarts from 'echarts';

export default {
  name: "Home",

  data() {
    return {
      expenseRatioYearOnYear: '',
      incomeRatioYearOnYear: '',
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      userCount: 0,
      bookCount: 0,
      eventCount: 0,
      fileCount: 0,
      myBookCount: 0,
      myEventCount: 0,
      total: 0,
      today: 0,
      extData: 0,
      currentMonthExpense: '',
      currentMonthIncome: '',
      lastMonthExpense: '',
      lastMonthIncome: '',
      year: new Date(),
      option1: {
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
            data: [],
            // data: this.chart1Data1,
            type: 'line'
          },
          {
            name: '个人购书趋势',
            data: [],
            // data: this.chart1Data2,
            type: 'line'
          }
        ]
      },
      option2: {
        title: {
          text: '个人购书年比例图',
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
            radius: ['40%', '60%'],
            data: [],
            // data: this.chart2Data,
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
      }
    }
  },
  created() {
    this.searchYear(this.year)
  },
  methods: {
    searchYear(n) {
      n = n.toString().split(' ')
      let changeYear = n[3]
      // console.log(changeYear)
      let toChangeYear = changeYear.toString()
      request.get("/echarts/booksNumber", {
        params: {
          year: toChangeYear
        }
      }).then(res => {
        this.option1.series[0].data = res.data;
      });
      request.get("/echarts/booksNumberOne", {
        params: {
          year: this.year,
          id: this.user.id
        }
      }).then(res => {
        this.option1.series[1].data = res.data;
        for (let i = 0; i < res.data.length; i++) {
          this.option2.series[0].data[i] = {name: i + "月", value: res.data[i]};
        }
      });
    }
  },
  watch(){
    this.option1.
  },
  mounted() {
    // 获取个人数据
    request.get("/home/getHomeOneInfo/" + this.user.id).then(res => {
      this.currentMonthExpense = res.data.billInfo.currentExpense;
      this.currentMonthIncome = res.data.billInfo.currentIncome;
      this.lastMonthExpense = res.data.billInfo.lastExpense;
      this.lastMonthIncome = res.data.billInfo.lastIncome;
      this.expenseRatioYearOnYear = res.data.billInfo.expenseRatioYearOnYear;
      this.incomeRatioYearOnYear = res.data.billInfo.incomeRatioYearOnYear;
      this.myBookCount = parseInt(res.data.commonInfo.myBookCount);
      this.bookCount = parseInt(res.data.commonInfo.booksCount);
      this.userCount = parseInt(res.data.commonInfo.usersCount);
      this.eventCount = parseInt(res.data.commonInfo.eventsCount);
      this.myEventCount = parseInt(res.data.commonInfo.myEventCount);
      this.fileCount = parseInt(res.data.commonInfo.filesCount);
    })
    // 折线图
    let myChart1 = echarts.init(document.getElementById('main'));

    // 饼图
    let myChart2 = echarts.init(document.getElementById('pie'));

    myChart1.setOption(this.option1);
    myChart2.setOption(this.option2);

  },

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
