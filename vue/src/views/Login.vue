<template>
  <div class="homepage-hero-module">
    <div class="video-container">
      <div :style="fixStyle" class="filter">
        <div style="width: 400px; margin: 100px auto">
          <div style="margin: 150px auto;width: 500px">
            <div
                style="color: #d7fd00;font-size:60px;text-align: center;font-family:KaiTi,serif;padding:80px 0">
              小沈家庭管理系统
            </div>
            <el-form ref="form" :model="form" style="margin: 0 100px" :rules="rules">
              <el-form-item prop="username">
                <!--                    <Avatar style="width: 1em; height: 1em; margin-right: 8px"></Avatar>-->
                <el-input :prefix-icon="User" placeholder="请输入用户名" v-model="form.username"/>
              </el-form-item>
              <el-form-item prop="password">
                <!--                    <Lock style="width: 1em; height: 1em; margin-right: 8px"></Lock>-->
                <el-input :prefix-icon="Lock" show-password placeholder="请输入密码"
                          v-model="form.password"/>
              </el-form-item>
              <el-form-item>
                <div style="display: flex;margin-right: 20px">
                  <el-input :prefix-icon="Key" v-model="form.validCode" style="width: 50%"
                            placeholder="请输入验证码"/>
                  <ValidCode @input="createValidCode"/>
                </div>
              </el-form-item>
              <el-form-item>
                <el-button style="flex:1;margin-bottom:20px" type="primary" @click="login">登录
                </el-button>
                <el-button style="margin-bottom:20px" type="primary"
                           @click="$router.push('/register')">前往注册>>
                </el-button>
              </el-form-item>
            </el-form>
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
import {User, Lock, Key} from "@element-plus/icons-vue"
import request from "../utils/request"
import ValidCode from "@/components/ValidCode"

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
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'}
        ]
      }
    }
  },
  created() {
    sessionStorage.removeItem("user")
  },
  setup() {
    return {
      User,
      Lock,
      Key
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
          if (!this.form.validCode) {
            this.$message.error("请填写验证码")
            return
          }
          if (this.form.validCode.toLowerCase() !== this.validCode.toLowerCase()) {
            this.$message.error("验证码错误")
            return
          }
          request.post("/user/login", this.form).then(res => {
            console.log(res)
            if (res.code === '0') {
              this.$message.success("登录成功")
              console.log(res)
              sessionStorage.setItem("user", JSON.stringify(res.data))  // 缓存用户信息
              this.$router.push("/index/") //登录成功后自动跳转到首页
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    canplay() {
      this.vedioCanPlay = true
    }
  }
}

</script>


<style scoped>
.homepage-hero-module,
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
}

.fillWidth {
  width: 100%;
}
</style>