<template>
    <div style="padding: 10px">
        <div style="margin: 10px 0">
            <el-button type="primary" @click="add">
                <el-icon>
                    <CirclePlus/>
                </el-icon>
                &nbsp新增
            </el-button>
        </div>
        <div style="margin: 10px 0;display: block;clear: both">
            <el-input v-model="name" placeholder="请输入类别名称" style="width: 20%" class="mr-10" :prefix-icon="Search"
                      clearable/>
            <el-input v-model="flag" placeholder="请输入类别标识" style="width: 20%" class="mr-10" :prefix-icon="Search"
                      clearable/>
            <el-button class="mb-10" type="primary" @click="search">查询</el-button>
            <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
        </div>
        <el-table
                v-loading="loading"
                :data="tableData"
                :header-cell-style="{'text-align':'center'}"
                border
                stripe
                style="width: 100%">
            <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
            <el-table-column prop="name" label="类别名称" align="center"/>
            <el-table-column prop="flag" label="唯一标识" align="center"/>
            <el-table-column fixed="right" label="操作" width="500px" align="center">
                <template #default="scope">
                    <!--                  后端也要有个bookList属性-->
                    <el-button plain type="success" @click="showBooks(scope.row.cbookList)">查看图书列表
                    </el-button>
                    <el-button plain type="primary" @click="handleEdit(scope.row)" v-if="user.role==='ROLE_ADMIN'">编辑
                    </el-button>
                    <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
                        <template #reference>
                            <el-button type="danger" v-if="user.role==='ROLE_ADMIN'">
                                <el-icon>
                                    <Delete/>
                                </el-icon>
                            </el-button>
                        </template>
                    </el-popconfirm>
                </template>
            </el-table-column>
            <el-pagination small layout="prev, pager, next" :total="50"/>
        </el-table>
        <div style="margin: 10px 0">
            <el-dialog title="图书列表" v-model="bookVis" width="60%">
                <el-table :data="cbookList" stripe border>
                    <el-table-column prop="id" label="ID" sortable="" align="center" width="70px"/>
                    <el-table-column prop="bookname" label="名称" align="center"/>
                    <el-table-column prop="author" label="作者" align="center"/>
                    <el-table-column prop="price" label="价格" align="center"/>
                    <el-table-column prop="buyDate" label="购买日期" align="center"/>
                </el-table>
            </el-dialog>

            <el-dialog v-model="dialogVisible" title="类别信息" width="30%">
                <el-form :model="form" label-width="120px" :rules="rules" ref="pass">
                    <el-form-item label="类别名称" prop="name">
                        <el-input v-model="form.name" style="width: 80%" autocomplete="off"/>
                    </el-form-item>
                    <el-form-item label="唯一标识" prop="flag">
                        <el-input v-model="form.flag" style="width: 80%" autocomplete="off"/>
                    </el-form-item>
                </el-form>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="submit" :loading="loading">提交</el-button>
                    </span>
                </template>
            </el-dialog>
        </div>
    </div>
</template>

<script>

    import request from "../utils/request";
    import {Search, Delete} from "@element-plus/icons-vue";

    export default {
        data() {
            return {
                loading: false,
                form: {},
                dialogVisible: false,
                bookVis: false,
                name: '',
                flag: '',
                tableData: [],
                cbookList: [],
                user: sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {},
                rules: {
                    name: [
                        {required: true, message: '类别名称不能为空', trigger: 'blur'},
                        {min: 2, max: 30, message: '长度在2~30位之间', trigger: 'blur'},
                    ],
                    flag: [
                        {required: true, message: '标识不能为空', trigger: 'blur'},
                        {min: 1, max: 3, message: '长度在1~3位之间', trigger: 'blur'},
                    ]
                }
            }
        },
        created() {
            this.search();
        },
        setup() {
            return {
                Search,
                Delete
            }
        },
        methods: {
            showBooks(cbookList) {
                this.bookVis = true;
                this.cbookList = cbookList;

            },
            search() {
                request.get("/category-list/search", {
                    params: {
                        name: this.name,
                        flag: this.flag,
                    }
                }).then(res => {
                    // console.log(res);
                    this.tableData = res.data
                });
            },
            reset() {
                this.name = '';
                this.flag = '';
                this.search();
            },
            add() {
                this.dialogVisible = true;
                // 清空表单域，点击取消后，下次打开就是清空内容了
                this.form = {}
            },

            submit() {
                this.$refs.pass.validate((valid) => {
                    if (valid) {
                        this.loading = true
                        request.post("/category-list", this.form).then(res => {
                            // console.log(res);
                            if (res.code === '0') {
                                this.$message.success("操作成功")
                                this.dialogVisible = false;
                                this.search();
                            } else {
                                this.$message.error(res.msg)
                            }
                            setTimeout(() => {
                                this.loading = false
                            }, 1000)
                        });
                    }
                })
            },
            handleEdit(row) {
                this.form = JSON.parse(JSON.stringify(row));
                this.dialogVisible = true
            },
            handleDelete(row) {
                this.id = row.id
                request.delete("/category-list/" + this.id).then(res => {
                    if (res.code === '0') {
                        this.$message.success("删除成功")
                    } else {
                        this.$message.error(res.msg)
                    }
                    this.search();//刷新表格数据
                })
            }
        }
    }
</script>
