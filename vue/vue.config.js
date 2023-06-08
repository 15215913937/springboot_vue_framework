const {defineConfig} = require('@vue/cli-service')
// module.exports = defineConfig({
//   transpileDependencies: true,
//   devServer:{
//     port: 8080, //设置端口号
//     host: 'localhost',}
// })
// 跨域配置
module.exports = {
    devServer: {                //记住，别写错了devServer
        // 设置本地默认端口  选填
        port: 92, //设置端口号
        // host: '118.89.121.243',
        host: '127.0.0.1',
        proxy: {                 //设置代理，必须填
            '/api': {              //设置拦截器  拦截器格式   斜杠+拦截器名字，名字可以自己定
                target: 'http://127.0.0.1:9090',     //代理的目标地址（本地）
                // target: 'http://118.89.121.243:9092',     //代理的目标地址（服务器）
                changeOrigin: true,              //是否设置同源，输入是的
                pathRewrite: {                   //路径重写
                    '^/api': ''                     //选择忽略拦截器里面的内容
                }
            }
        },
        historyApiFallback: true,
        allowedHosts: "all",
    }
}
