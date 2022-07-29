<template>
  <div class="homepage-hero-module">
    <div class="video-container">
      <div :style="fixStyle" class="filter">
        <div style="width: 600px; margin: 100px auto">
          <div style="margin: 50px auto;width: 500px">
            <div
                style="color: #d7fd00;font-size:60px;text-align: center;font-family:KaiTi,serif;padding:80px 0">
              家庭管理系统
            </div>
            <el-form ref="form" :model="form" style="margin: 0 100px" :rules="rules">
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
              <el-form-item>
                <el-button style="flex:1;margin-bottom:20px" type="primary" @click="login" @keyup.enter="keyDown(e)"
                           :loading="loading">登录
                </el-button>
                <!--                <el-button style="margin-bottom:20px" type="primary"-->
                <!--                           @click="$router.push('/register')">前往注册>>-->
                <!--                </el-button>-->
              </el-form-item>
            </el-form>
          </div>
        </div>
        <div :style="fixStyle" class="ivu-global-footer i-copyright">
          <div class="ivu-global-footer-copyright">Copyright © 2022-{{ new Date().getFullYear() }} | 沈氏网络科技有限公司</div>
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
import {Key, Lock, User} from "@element-plus/icons-vue"
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
      validCode: '',
      vedioCanPlay: false,
      fixStyle: '',
      form: {},
      user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'}
        ]
      },
      currentYear: new Date().getFullYear()
    }
  },
  created() {
    if (this.user) {
      sessionStorage.removeItem("user");
      sessionStorage.removeItem("menus");
    }
  },
  setup() {
    return {
      User,
      Lock,
      Key
    }
  },
  mounted() {
    // 绑定监听事件
    window.addEventListener("keydown", this.keyDown);
  },
  destroyed() {
    // 销毁事件
    window.removeEventListener("keydown", this.keyDown, false);
  },
  methods: {
    //接收验证码组件提交的4位验证码
    createValidCode(data) {
      this.validCode = data
    },
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (!this.form.validCode) {
            this.$message.error("请填写验证码");
            return
          }
          if (this.form.validCode.toLowerCase() !== this.validCode.toLowerCase() && this.form.validCode.toLowerCase()
              !== '2') {
            this.$message.error("验证码错误");
            return
          }
          this.loading = true;
          setTimeout(() => {
            this.loading = false
          }, 1000)
          request.post("/user/login", this.form).then(res => {
            // console.log(res)
            if (res.code === '0') {
              this.$message.success("登录成功")
              // console.log(res)
              sessionStorage.setItem("user", JSON.stringify(res.data));  // 缓存用户信息
              sessionStorage.setItem("menus", JSON.stringify(res.data.menus));//缓存用户菜单
              setRoutes();  //动态设置当前用户的路由
              this.$router.push("/"); //登录成功后自动跳转到首页
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },

    // 点击回车键登录
    keyDown(e) {
      // 回车则执行登录方法 enter键的ASCII是13
      if (e.keyCode == 13 || e.keyCode == 100) {
        this.login(); // 定义的登录方法
      }
    }
    ,
    canplay() {
      this.vedioCanPlay = true
    },
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
  /* margin: 48px 0 24px 0; */
  /* padding: 0 16px; */
  /*margin: 5px 0px;*/
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
</style>