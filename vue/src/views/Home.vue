<template>
    <div style="padding: 25px;display: flex">
        <div style="flex: 1">
            <div style="flex: 1;display: flex;max-height:400px">
                <el-card style="width:90%">
                    <div style="margin: 10px">
                        <div style="font-size: 20px;margin-bottom: 10px;width: 50%">
                            <el-icon>
                                <WalletFilled/>
                            </el-icon>
                            我的账单
                        </div>
                    </div>
                    <div style="margin: 10px">
                        <el-card style="margin: 10px;font-size: 20px">
                            本月已消费
                            <!--                          支出绿，收入红-->
                            <span :style="{color:currentColor,float: billRight}">
                {{ currentSymbol }}{{ currentMonthBill.toFixed(2) }}元
              </span>
                        </el-card>
                        <el-card style="margin: 10px;font-size: 15px">
                            上月消费
                            <span :style="{color:lastColor,float: billRight}">
                {{ lastSymbol }}{{ lastMonthBill.toFixed(2) }}元
              </span>
                        </el-card>
                    </div>
                </el-card>
            </div>
            <div style="flex: 1">
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
        <div style="flex: 1;display: flex;flex-direction: column">
            <div style="flex: 1">
                <el-row :gutter="10" style="margin-bottom: 15px">
                    <el-col :span="6">
                        <el-card style="color: #E6A23C">
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
                        <el-card style="color: #67C23A">
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
                        <el-card style="color: #67C23A">
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
                        <el-card style="color: #67C23A">
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
            <div style="flex: 1">

            </div>
        </div>


    </div>
</template>

<script>
    import request from "../utils/request";
    import * as echarts from 'echarts';
    import china from '@/utils/china'

    export default {
        name: "Home",
        data() {
            return {
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
                currentMonthBill: 0,
                lastMonthBill: 0,
                currentSymbol: '+',
                lastSymbol: '-',
                currentColor: 'red',
                lastColor: 'green',
                billRight: 'right',
            }
        },
        mounted() {  //页面元素渲染完成后再触发mounted
            let that = this;
            //获取家族注册人数和个人书籍数量
            request.get("/user").then(res => {
                this.userCount = res.data.total;
            });
            //获取个人书籍
            request.get("/book/byUid", {
                params: {
                    uid: that.user.id,
                }
            }).then(res => {
                this.myBookCount = res.data.total;
            });
            //获取书籍总数
            request.get("/book").then(res => {
                this.bookCount = res.data.total
            });
            //获取事件总数和个人事件
            request.get("/events").then(res => {
                // console.log(res.data.records)
                this.eventCount = res.data.total
                let myEvents = res.data.records;
                let count = 0;
                for (const myEvent of myEvents) {
                    if (myEvent.author === this.user.name) {
                        count += 1
                    }
                }
                this.myEventCount = count
            });
            //获取文件总数
            request.get("/files").then(res => {
                // console.log(res.data.records.length)
                this.fileCount = res.data.total
            });
            //折线图
            const chartDom1 = document.getElementById('main');
            const myChart1 = echarts.init(chartDom1);
            const option1 = {
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
                        type: 'line'
                    },
                    {
                        name: '个人购书趋势',
                        data: [],
                        type: 'line'
                    }
                ]
            };


            //饼图
            const chartDom2 = document.getElementById('pie');
            const myChart2 = echarts.init(chartDom2);
            const option2 = {
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
            request.get("/echarts/booksNumber").then(res => {
                option1.series[0].data = res.data;
                //数据准备完毕后再setOption
                myChart1.setOption(option1);
                // console.log(res)

            });
            //个人购书折线图
            request.post("/echarts/booksNumberOne", this.user).then(res => {
                option1.series[1].data = res.data;
                myChart1.setOption(option1);
                for (let i = 0; i < res.data.length; i++) {
                    option2.series[0].data[i] = {name: i + "月", value: res.data[i]};
                }
                myChart2.setOption(option2);
            });
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


    /*.chart {*/
    /*    height: 300px*/
    /*}*/

</style>
