<template>
  <vue-particles
      color="#F56C6C"
      :particleOpacity="0.7"
      :particlesNumber="60"
      shapeType="triangle"
      :particleSize="6"
      linesColor="#000000"
      :linesWidth="1"
      :lineLinked="true"
      :lineOpacity="0.4"
      :linesDistance="150"
      :moveSpeed="3"
      :hoverEffect="true"
      hoverMode="grab"
      :clickEffect="true"
      clickMode="push" id="particles-js">
  </vue-particles>
  <div style="height: 100vh;width: 100%;overflow: hidden;background-color: darkslateblue">
    <div style="margin: 100px auto;width: 500px">
      <div
          style="color: #cccccc;font-size: 50px;text-align: center;font-family:KaiTi,serif;padding:30px 0">
        欢迎注册
      </div>
      <el-form ref="form" :model="form" style="margin: 0 100px" :rules="rules">
        <el-form-item prop="username">
          <el-input placeholder="请输入用户名" v-model="form.username"/>
        </el-form-item>
        <el-form-item prop="password">
          <el-input show-password placeholder="请输入密码" v-model="form.password"/>
        </el-form-item>
        <el-form-item prop="confirm">
          <el-input show-password placeholder="请再次输入密码" v-model="form.confirm"/>
        </el-form-item>
        <el-form-item style="flex: auto">
          <el-button style="margin-bottom:20px;flex: 1" type="primary" @click="register" :loading="loading">注册
          </el-button>
          <el-button style="margin-bottom:20px" type="primary" @click="$router.push('/login')">已有账号？返回登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";

export default {
  name: "Register",
  data() {
    return {
      form: {},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 20, message: '限制输入3~20个字符哦', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 3, max: 20, message: '限制输入3~20个字符哦', trigger: 'blur'}
        ],
        confirm: [
          {required: true, message: '请再次输入密码', trigger: 'blur'}
        ]
      }
    }
  },
  methods: {
    register() {
      if (this.form.password !== this.form.confirm) {
        this.$message.error("两次密码输入不一致")
        return
      }
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1000)
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/register", this.form).then(res => {
            if (res.code === '0') {
              this.$message.success("注册成功")
              this.$router.push("/login") //注册成功后自动跳转到登录页
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}

</script>


<style scoped>
#particles-js {
  width: 100%;
  height: calc(100% - 100px);
  position: absolute;
}
</style>