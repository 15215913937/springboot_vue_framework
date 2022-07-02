<template>
  <div class="homepage-hero-module">
    <div class="video-container">
      <div :style="fixStyle" class="filter">
        <div style="width: 400px; margin: 100px auto">
          <div style="margin: 150px auto;width: 500px">
            <div
                style="color: #cccccc;font-size: 50px;text-align: center;font-family:KaiTi,serif;padding:30px 0">
              小沈家庭管理系统
            </div>
            <el-form ref="form" :model="form" style="margin: 0 100px" :rules="rules">
              <el-form-item prop="username">
                <!--                    <Avatar style="width: 1em; height: 1em; margin-right: 8px"></Avatar>-->
                <el-input :prefix-icon="User" placeholder="请输入用户名" v-model="form.username"/>
              </el-form-item>
              <el-form-item prop="password">
                <!--                    <Lock style="width: 1em; height: 1em; margin-right: 8px"></Lock>-->
                <el-input :prefix-icon="Lock" show-password placeholder="请输入密码" v-model="form.password"/>
              </el-form-item>
              <el-form-item>
                <el-button style="flex:1;margin-bottom:20px" type="primary" @click="login">登录</el-button>
                <el-button style="flex:1;margin-bottom:20px" type="primary" @click="$router.push('/register')">前往注册>>
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
import {User, Lock} from "@element-plus/icons-vue"
import request from "../utils/request";

export default {
  name: "Login",
  data() {
    return {
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
  setup() {
    return {
      User,
      Lock
    }
  },
  // mounted() {
  //   sessionStorage.removeItem("user")
  //
  //   window.onresize = () => {
  //     const windowWidth = document.body.clientWidth
  //     const windowHeight = document.body.clientHeight
  //     const windowAspectRatio = windowHeight / windowWidth
  //     let videoWidth
  //     let videoHeight
  //     if (windowAspectRatio < 0.5625) {
  //       videoWidth = windowWidth
  //       videoHeight = videoWidth * 0.5625
  //       this.fixStyle = {
  //         height: windowWidth * 0.5625 + 'px',
  //         width: windowWidth + 'px',
  //         'margin-bottom': (windowHeight - videoHeight) / 2 + 'px',
  //         'margin-left': 'initial'
  //       }
  //     } else {
  //       videoHeight = windowHeight
  //       videoWidth = videoHeight / 0.5625
  //       this.fixStyle = {
  //         height: windowHeight + 'px',
  //         width: windowHeight / 0.5625 + 'px',
  //         'margin-left': (windowWidth - videoWidth) / 2 + 'px',
  //         'margin-bottom': 'initial'
  //       }
  //     }
  //   }
  //   window.onresize()
  // },
  methods: {
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
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