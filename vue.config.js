const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer:{
    port: 8080, //设置端口号
    host: 'localhost',}
})

