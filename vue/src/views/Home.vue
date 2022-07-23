<template>
    <div style="padding: 25px">
        <el-row :gutter="10" style="margin-bottom: 15px">
            <el-col :span="6">
                <el-card style="color: #E6A23C">
                    <div>
                        <el-icon>
                            <HomeFilled/>
                        </el-icon>
                        家族注册人数
                    </div>
                    <div class="number"><span>{{userCount}} 人</span></div>
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
                    <div class="number"><span>{{bookCount}} 本</span></div>
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
                    <div class="number"><span>{{eventCount}} 件</span></div>
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
                    <div class="number"><span>{{fileCount}} 份</span></div>
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
                    <div class="userNumber"><span>{{userCount}} 本</span></div>
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
                    <div class="userNumber"><span>{{userCount}} 件</span></div>
                </el-card>
            </el-col>
        </el-row>
        <!--        图表-->
        <el-row :gutter="50">
            <el-col :span="12">
                <div id="main" style="width: 400px;height: 300px"/>
            </el-col>
            <el-col :span="12">
                <div id="pie" style="width: 400px;height: 300px"/>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import request from "../utils/request";
    import * as echarts from 'echarts'

    export default {
        name: "Home",
        data() {
            return {
                userCount:"",
                bookCount:"",
                eventCount:"",
                fileCount:""
            }
        },
        mounted() {  //页面元素渲染完成后再触发mounted
            //获取家族注册人数
            request.get("/user").then(res=>{
                this.userCount = res.data.records.length
            })
            //获取书籍总数
            request.get("/book").then(res=>{
                this.bookCount = res.data.records.length
            })
            //获取事件总数
            request.get("/events").then(res=>{
                // console.log(res.data.records.length)
                this.eventCount = res.data.records.length
            })
            //获取文件总数
            request.get("/files").then(res=>{
                // console.log(res.data.records.length)
                this.fileCount = res.data.records.length
            })
            //折线图
            var chartDom1 = document.getElementById('main');
            var myChart1 = echarts.init(chartDom1);
            var option1 = {
                title: {
                    text: '购书趋势图',
                },
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
                        data: ['2', '5', '10', '3', '3', '3', '4'],
                        type: 'line'
                    }
                ]
            };


            //饼图
            var chartDom2 = document.getElementById('pie');
            var myChart2 = echarts.init(chartDom2);
            var option2 = {
                title: {
                    text: '每月购书比例图',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{b} <br/>{c}本  ({d}%)'
                },
                legend: {
                    top: '5%',
                    left: 'center'
                },
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
                        },
                        avoidLabelOverlap: false,
                    },
                ]
            };
            request.get("/echarts/booksNumber").then(res => {
                option1.series[0].data = res.data;
                //数据准备完毕后在setOption
                myChart1.setOption(option1);
                option2.series[0].data = [
                    {name: "1月", value: res.data[0]},
                    {name: "2月", value: res.data[1]},
                    {name: "3月", value: res.data[2]},
                    {name: "4月", value: res.data[3]},
                    {name: "5月", value: res.data[4]},
                    {name: "6月", value: res.data[5]},
                    {name: "7月", value: res.data[6]},
                    {name: "8月", value: res.data[7]},
                    {name: "9月", value: res.data[8]},
                    {name: "10月", value: res.data[9]},
                    {name: "11月", value: res.data[10]},
                    {name: "12月", value: res.data[11]}
                ];
                myChart2.setOption(option2);
            })

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
