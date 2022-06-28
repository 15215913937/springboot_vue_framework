<template>

  <div style="height: 100vh;width: 100%;overflow: hidden;background-color: darkslateblue">
    <div style="margin: 150px auto;width: 500px">
      <div
          style="color: #cccccc;font-size: 50px;text-align: center;font-family:KaiTi,serif;padding:30px 0">
        管理系统
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
          <el-button style="flex:1;margin-bottom:20px" type="primary" @click="$router.push('/register')">注册</el-button>
        </el-form-item>
      </el-form>
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
  setup(){
    return {
      User,
      Lock
    }
  },
  methods: {
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/login", this.form).then(res => {
            if (res.code === '0') {
              this.$message.success("登录成功")
              this.$router.push("/") //登录成功后自动跳转到主页
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  },
  components: {
  }
}

</script>


<style scoped>

</style>