<template>
  <div class="container">
    <h2>扫码登录Demo</h2>
    <qrcode :value="qrcodeValue" :size="200"/>
    <p v-if="!isLogin">请使用微信扫描二维码进行登录</p>
    <p v-else>登录成功，欢迎您，{{ username }}！</p>
  </div>

</template>


<script>
import Qrcode from 'qrcode.vue';
import request from "@/utils/request";

export default {
  name: 'ScanLogin',
  components: {
    Qrcode,
  },
  data() {
    return {
      qrcodeValue: '',
      isLogin: false,
      username: '',
    };
  },
  mounted() {
    // 生成二维码
    this.generateQrcode();
  },
  methods: {
    generateQrcode() {
      // 向服务端请求二维码值
      // 此处省略具体实现
      // ...
      // const response = 'a87fdg7fd9h03jfn';
      const response = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=xxxxxxxxxxxxxxxxx&redirect_uri=http://example.com/wechatLogin&response_type=code&scope=snsapi_login&state=123#wechat_redirect';

      this.qrcodeValue = response;
      // 轮询检查是否已登录
      const timer = setInterval(() => {
        // 向服务端请求登录状态
        // 此处省略具体实现
        // ...
        const isLogin = true;// 假设已登录成功
        if (isLogin) {
          clearInterval(timer);
          this.isLogin = true;
          this.username = 'Tom';// 假设获取到登录用户的用户名
        }
      }, 1000);
    },
  },
};
</script>
<style scoped>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 50px;
}

h2 {
  margin-bottom: 20px;
}

p {
  margin-top: 20px;
}
</style>