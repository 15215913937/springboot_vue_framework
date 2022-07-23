<template>
    <div>
        <el-card style="width: 40%;margin: 10px">
            <el-form label-width="80px">
                <el-upload
                        class="avatar-uploader"
                        action="http://localhost:9090/files/testUpload"
                        :show-file-list="false"
                        :on-success="handleAvatarSuccess"
                >
                    <img v-if="form.avatar" :src="form.avatar" class="avatar"/>
                    <el-icon v-else class="avatar-uploader-icon">
                        <Plus/>
                    </el-icon>
                </el-upload>
                <el-form-item label="用户名">
                    <el-input v-model="form.username"></el-input>
                </el-form-item>
                <el-form-item label="姓名">
                    <el-input v-model="form.name"></el-input>
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
                    <el-input v-model="form.sex"></el-input>
                </el-form-item>
                <el-form-item label="角色">
                    <el-input v-model="form.role" disabled></el-input>
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

    export default {
        name: "Person",
        data() {
            return {
                form: {},
            }
        },
        created() {
            let str = sessionStorage.getItem("user") || "{}"
            this.form = JSON.parse(str)
        },
        methods: {
            update() {
                this.loading = true;
                setTimeout(() => {
                    this.loading = false
                }, 1000)
                request.put("/user", this.form).then(res => {
                    // console.log(res);
                    if (res.code === '0') {
                        this.$message.success("保存成功")
                        //更新浏览器存储的用户信息
                        sessionStorage.setItem("user", JSON.stringify(this.form))
                        //出发父级更新user方法
                        this.$emit("userInfo")
                    } else {
                        this.$message.error(res.msg)
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