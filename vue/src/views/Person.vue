<template>
    <div>
        <el-card style="width: 40%;margin: 10px">
            <el-form label-width="80px" :rules="rules" :model="form" ref="pass">
                <el-upload
                        class="avatar-uploader"
                        :action="'http://'+ serverIp +':9090/files/testUpload'"
                        :show-file-list="false"
                        :on-success="handleAvatarSuccess"
                >
                    <img v-if="form.avatar" :src="form.avatar" class="avatar"/>
                    <el-icon v-else class="avatar-uploader-icon">
                        <Plus/>
                    </el-icon>
                </el-upload>
                <el-form-item label="用户名" prop="username">
                    <el-input v-model="form.username"></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="电话" prop="phone">
                    <el-input v-model="form.phone"></el-input>
                </el-form-item>
                <el-form-item label="出生日期">
                    <el-date-picker
                            v-model="form.birthday"
                            type="date"
                            clearable
                            style="width: 100%"
                            format="YYYY/MM/DD"
                            value-format="YYYY-MM-DD"
                    />
                </el-form-item>
                <el-form-item label="性别">
                    <el-input v-model="form.sex" disabled></el-input>
                </el-form-item>
                <el-form-item label="角色">
                    <el-tag type="primary" v-if="form.role === 'ROLE_ADMIN'">管理员</el-tag>
                    <el-tag type="warning" v-if="form.role === 'ROLE_USER'">普通用户</el-tag>
                    <el-tag type="success" v-if="form.role === 'ROLE_VISITOR'">游客</el-tag>
                    <el-tag type="error" v-if="form.role === 'ROLE_TESTER'">测试用户</el-tag>
                </el-form-item>
                <div style="text-align: center">
                    <el-button type="primary" @click="update" :loading="loading">保存</el-button>
                </div>

            </el-form>
        </el-card>
    </div>
</template>

<script>
    import request from "../utils/request";
    import {serverIp} from "../../public/config";

    export default {
        name: "Person",
        data() {
            const isMobileNumber = (rule, value, callback) => {
                const reg = /^1[3|4|5|7|8][0-9]\d{8}$/;
                const isPhone = reg.test(value);
                if (value.length < 0 || value.length > 11 || !isPhone) { //判断是否为11位手机号
                    callback(new Error("手机号码格式不正确"));
                } else {
                    callback();
                }
            };
            return {
                form: {},
                serverIp: serverIp,
                loading: false,
                rules: {
                    username: [
                        {required: true, message: '用户名不能为空', trigger: 'blur'},
                        {min: 3, max: 20, message: '长度在3~20位之间', trigger: 'blur'},
                    ],
                    phone: [
                        {required: true, message: '用户名不能为空', trigger: 'blur'},
                        {validator: isMobileNumber, trigger: 'blur'},
                    ],
                }
            }
        },
        created() {
            this.form = JSON.parse(sessionStorage.getItem("user") || {});
        },
        methods: {
            update() {
                this.$refs.pass.validate(valid => {
                    if (valid) {
                        this.loading = true;
                        // console.log(this.form);
                        request.post("/user", this.form).then(res => {
                            // console.log(res);
                            if (res.code === '0') {
                                this.$message.success("保存成功");
                                //更新浏览器存储的用户信息
                                sessionStorage.setItem("user", JSON.stringify(this.form));
                                //触发父级更新user方法
                                this.$emit("userInfo")
                            } else {
                                this.$message.error(res.msg)
                            }
                            setTimeout(() => {
                                this.loading = false
                            }, 1000)
                        })
                    }
                })
            }
            ,
            handleAvatarSuccess(res) {
                this.form.avatar = res
            }
        }
    }
</script>

<style>
    .avatar-uploader {
        text-align: center;
        margin-bottom: 10px;
    }

    .avatar-uploader .el-upload {
        border: 1px dashed var(--el-border-color);
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        transition: var(--el-transition-duration-fast);
    }

    .avatar-uploader .el-upload:hover {
        border-color: var(--el-color-primary);
    }

    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 150px;
        height: 150px;
        text-align: center;
    }

    .avatar {
        width: 150px;
        height: 150px;
        text-align: center;
    }

</style>