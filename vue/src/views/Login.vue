<template>
  <div class="homepage-hero-module">
    <div class="video-container">
      <div :style="fixStyle" class="filter">
        <div
            style="width: 600px;height: 500px;margin: 100px auto;display: flex;flex-direction: column;align-items: center;">
          <div
              style="display:flex;flex:2;justify-content: center;align-items:center;color: #d7fd00;font-size:60px;font-family:KaiTi,serif">
            <span>家庭管理系统</span>
          </div>
          <div style="flex: 3;width: 300px;display: flex;flex-direction: column;">
            <div style="display: flex;height: 50px;align-items: center;text-align: center">
              <div style="flex: 1">
                <el-button type="warning" @click="setLoginWay(loginWay=0)">账号登录</el-button>
              </div>
              <div style="flex: 1">
                <el-button type="warning" @click="setLoginWay(loginWay=1)">手机号登录</el-button>
              </div>
            </div>
            <div style="flex: 1;display: flex;align-items: center">
              <el-form v-if="loginWay===0" ref="form" :model="form" :rules="rules">
                <el-form-item prop="username">
                  <el-input :prefix-icon="User" placeholder="请输入用户名" v-model="form.username"/>
                </el-form-item>
                <el-form-item prop="password">
                  <el-input :prefix-icon="Lock" show-password placeholder="请输入密码"
                            v-model="form.password"/>
                </el-form-item>
                <el-form-item>
                  <div style="display: flex">
                    <el-input :prefix-icon="Key" v-model="form.validCode" style="width: 50%"
                              placeholder="请输入验证码"/>
                    <div style="background-color: #FFFFFF;border-radius: 4px;margin-left: 10px">
                      <ValidCode @input="createValidCode"/>
                    </div>

                  </div>
                </el-form-item>
              </el-form>
              <el-form v-if="loginWay===1" ref="form" :model="form" :rules="rules">
                <el-form-item prop="phone" style="display: flex">
                  <el-input style="flex: 2" :prefix-icon="Iphone" placeholder="请输入手机号"
                            v-model="form.phone"/>
                  <el-button
                      style="flex: 1;line-height: 30px;border-radius:5px"
                      @click="sendCode"
                      :class="{disabled:this.clockStatus}"
                  >
                    {{ sendContent }}
                  </el-button>
                </el-form-item>
                <el-form-item prop="code">
                  <el-input :prefix-icon="Key" placeholder="请输入验证码" v-model="form.code"/>
                </el-form-item>
              </el-form>
            </div>
          </div>
          <div style="flex: 1;display: flex;align-items: center">
            <el-button type="primary"
                       style="width: 300px"
                       @click="login"
                       @keyup.enter=login
                       :loading=loading>登&nbsp&nbsp&nbsp&nbsp录
            </el-button>
          </div>
        </div>
        <div :style="fixStyle" class="ivu-global-footer i-copyright">
          <div class="ivu-global-footer-copyright">Copyright © 2022-{{ new Date().getFullYear() }} |
            沈氏网络科技有限公司
          </div>
        </div>
      </div>
      <video :style="fixStyle" autoplay loop muted class="fillWidth" v-on:canplay="canplay">
        <source src="../assets/sea.mp4" type="video/mp4"/>
        <!--        浏览器不支持 video 标签，建议升级浏览器。-->
      </video>

    </div>
  </div>
</template>

<script>
import {Key, Lock, User, Iphone} from "@element-plus/icons-vue"
import request from "../utils/request"
import ValidCode from "@/components/ValidCode"
import {setRoutes} from "@/router";

export default {
  name: "Login",
  components: {
    ValidCode
  },
  data() {
    return {
      sendContent: "发送验证码",
      totalTime: 60,
      clockStatus: false,
      loginWay: 0,
      validCode: '',
      vedioCanPlay: false,
      fixStyle: '',
      form: {},
      loading: false,
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'}
        ],
        phone: [
          {required: true, message: '请输入手机号', trigger: 'blur'}
        ],
        code: [
          {required: true, message: '请输入验证码', trigger: 'blur'}
        ]
      },
      currentYear: new Date().getFullYear()
    }
  },
  created() {
    if (sessionStorage.getItem("user")) {
      sessionStorage.removeItem("user");
      sessionStorage.removeItem("menus");
    }
  },
  setup() {
    return {
      User,
      Lock,
      Key,
      Iphone
    }
  },
  methods: {
    //接收验证码组件提交的4位验证码
    createValidCode(data) {
      this.validCode = data
    },
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (this.loginWay === 0) {
            if (!this.form.validCode) {
              this.$message.error("请填写验证码");
              return
            }
            if (this.form.validCode.toLowerCase() !== this.validCode.toLowerCase() && this.form.validCode.toLowerCase()
                !== '2') {
              this.$message.error("验证码错误");
              return
            }
          } else if (this.loginWay === 1) {
            if (!this.form.phone) {
              this.$message.error("请填写验证码");
              return
            }
            if (!this.form.code && this.form.code !== '2') {
              this.$message.error("验证码不能为空");
              return
            }
          }
          this.loading = true;
          setTimeout(() => {
            this.loading = false
          }, 500)
          request.post("/user/login", this.form).then(res => {
            if (res.code === '0') {
              sessionStorage.setItem("user", JSON.stringify(res.data));  // 缓存用户信息
              sessionStorage.setItem("menus", JSON.stringify(res.data.menus));// 缓存用户菜单
              setRoutes();  // 动态设置当前用户的路由
              this.$router.push("/"); // 登录成功后自动跳转到首页
              this.$message.success("登录成功");
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    canplay() {
      this.vedioCanPlay = true
    },
    setLoginWay() {
      this.form = {};
    },
    sendCode() {
      request.post("/user/sendCode", this.form.phone).then(res => {
        if (res.code === "0") {
          if (this.clockStatus) return;
          let clock = setInterval(() => {
            this.clockStatus = true;
            this.sendContent = this.totalTime + "s后重新发送";
            --this.totalTime;
            if (this.totalTime < 0) {
              this.clockStatus = false;
              clearInterval(clock);
              this.totalTime = 60;
              console.log(this.clockStatus);
              this.sendContent = "重新发送"
            }
          }, 1000)
        } else {
          this.$message.error(res.msg);
        }
      })

    }
  }
}

</script>


<style scoped>

.video-container {
  position: relative;
  height: 100vh;
  overflow: hidden;
}

.video-container .poster img {
  z-index: 0;
  position: absolute;
}

.video-container .filter {
  z-index: 1;
  position: absolute;
  /*background: rgba(0, 0, 0, 0.4);*/
  width: 100%;
  height: 100vh;
}

.fillWidth {
  width: 100%;
}

.ivu-global-footer {
  text-align: center;
  box-sizing: border-box;
  margin-bottom: 20px;
  bottom: 20px;
}

.i-copyright {
  flex: 0 0 auto;
}

.ivu-global-footer-copyright {
  color: #a0cfff;
  font-size: 14px;
}

.disabled {
  /*background-color: gray;*/
  color: #8c939d;
  pointer-events: none;
}
</style>