<template>
    <div>
        <el-row>
            <el-col :span="12">
                <div id="main" style="width: 500px;height: 400px"/>
            </el-col>
            <el-col :span="12">
                <div id="pie" style="width: 500px;height: 400px"/>
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
            return {}
        },
        mounted() {  //页面元素渲染完成后再触发mounted
            //折线图
            var chartDom1 = document.getElementById('main');
            var myChart1 = echarts.init(chartDom1);
            var option1 = {
                xAxis: {
                    type: 'category',
                    data: []
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: [],
                        type: 'line'
                    }
                ]
            };
            request.get("/echarts/example").then(res => {
                option1.xAxis.data = res.data.x;
                option1.series[0].data = res.data.y
                //数据准备完毕后在setOption
                myChart1.setOption(option1);
            })


            //饼图
            var chartDom2 = document.getElementById('pie');
            var myChart2 = echarts.init(chartDom2);
            var option2 = {
                title: {
                    text: 'Referer of a Website',
                    subtext: 'Fake Data',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: [
                            {value: 1048, name: 'Search Engine'},
                            {value: 735, name: 'Direct'},
                            {value: 580, name: 'Email'},
                            {value: 484, name: 'Union Ads'},
                            {value: 300, name: 'Video Ads'}
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart2.setOption(option2);
        },
        methods: {}
    }

</script>

<style scoped>

</style>
