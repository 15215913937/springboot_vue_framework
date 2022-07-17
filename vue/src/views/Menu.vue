<template>
    <div style="padding: 10px">
        <!--    功能区-->
        <div style="margin: 10px 0">
            <el-button type="primary" @click="add">
                <el-icon>
                    <CirclePlus/>
                </el-icon>
                &nbsp新增
            </el-button>
        </div>
        <!--    搜索区-->
        <div style="margin: 10px 0;display: block;clear: both">
            <el-input v-model="name" placeholder="请输入菜单名称" style="width: 20%" class="mr-10" :prefix-icon="Search"
                      clearable/>
            <el-button class="mb-10" type="primary" @click="load">查询</el-button>
            <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
        </div>
        <!--    列表区-->
        <!--        stripe:斑马纹-->
        <el-table
                v-loading="loading"
                :data="tableData"
                row-key="id"
                default-expand-all
                border
                stripe
                style="width: 100%"
                @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"/>
            <!--            sortable:排序操作-->
            <el-table-column prop="id" label="ID" sortable=""/>
            <el-table-column prop="name" label="菜单名称"/>
            <el-table-column prop="path" label="路径"/>
            <el-table-column prop="icon" label="图标"/>
            <el-table-column prop="description" label="描述"/>
            <el-table-column fixed="right" label="操作" width="300px">
                <template #default="scope">
                    <el-button plain type="primary" @click="handleAdd(scope.row.id)"
                               v-if="!scope.row.pid && !scope.row.path">
                        <el-icon>
                            <Plus/>
                        </el-icon>
                        新增子菜单
                    </el-button>
                    <el-button plain type="primary" @click="handleEdit(scope.row)">编辑</el-button>
                    <el-popconfirm title="你确定要删除吗?" @confirm="handleDelete(scope.row)">
                        <template #reference>
                            <el-button type="danger">
                                <el-icon>
                                    <Delete/>
                                </el-icon>
                            </el-button>
                        </template>
                    </el-popconfirm>
                </template>
            </el-table-column>
        </el-table>
        <div style="margin: 10px 0">
            <el-dialog v-model="dialogVisible" title="菜单信息" width="30%">
                <el-form model="form" label-width="120px">
                    <el-form-item label="菜单名称">
                        <el-input v-model="form.name" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="路径">
                        <el-input v-model="form.path" style="width: 80%"/>
                    </el-form-item>
                    <el-form-item label="图标">
                        <el-select v-model="form.icon" clearable placeholder="选择图标">
                            <el-option
                                    v-for="item in options"
                                    :key="item.value"
                                    :label="item.name"
                                    :value="item.value"
                            >
                                <el-icon>
                                    <component :is="item.value"></component>
                                </el-icon>
                                <span>{{item.name}}</span>
                            </el-option>

                        </el-select>
                    </el-form-item>
                    <el-form-item label="描述">
                        <el-input type="textarea" v-model="form.description" style="width: 80%"/>
                    </el-form-item>
                </el-form>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="dialogVisible = false">取消</el-button>
                        <el-button type="primary" @click="save">提交</el-button>
                    </span>
                </template>
            </el-dialog>
        </div>

    </div>
</template>

<script>

    import request from "../utils/request";
    import {Search, Delete} from "@element-plus/icons-vue";
    import User from "./User";

    export default {
        name: 'Menu',
        components: {User},
        data() {
            return {
                loading: true,
                form: {},
                dialogVisible: false,
                name: '',
                tableData: [],
                options: []
            }
        },
        created() {
            this.load();
        },
        setup() {
            return {
                Search,
                Delete
            }
        },
        methods: {
            load() {
                this.loading = true;
                request.get("/menu", {
                    params: {
                        name: this.name
                    }
                }).then(res => {
                    // console.log(res);
                    this.loading = false;
                    this.tableData = res.data;
                })
            },
            reset() {
                this.name = '';
                this.load();
            },
            add() {
                this.dialogVisible = true;
                // 清空表单域，点击取消后，下次打开就是清空内容了
                this.form = {}
            },
            save() {
                if (this.form.id) {//若果id存在，更新
                    request.post("/menu", this.form).then(res => {
                        // console.log(res);
                        if (res.code === '0') {
                            this.$message.success("修改成功")
                        } else {
                            this.$message.error(res.msg)
                        }
                        this.load();//刷新表格数据
                        this.dialogVisible = false
                    });
                } else {//如果id不存在，新增
                    request.post("/menu", this.form).then(res => {
                        // console.log(res);
                        if (res.code === '0') {
                            this.$message.success("新增成功")
                        } else {
                            this.$message.error(res.msg)
                        }
                        this.load(); //刷新表格数据
                        this.dialogVisible = false
                    });
                }
            },
            handleEdit(row) {
                this.form = JSON.parse(JSON.stringify(row));
                this.dialogVisible = true;

                //请求图标的数据
                request.get("/menu/icons").then(res => {
                    this.options = res.data;
                })
            },
            handleDelete(row) {
                this.id = row.id;
                // console.log(this.id);
                request.delete("/menu/" + this.id).then(res => {
                    if (res.code === '0') {
                        this.$message.success("删除成功")
                    } else {
                        this.$message.error(res.msg)
                    }
                    this.load();//刷新表格数据
                })
            },
            handleAdd(pid) {
                this.dialogVisible = true
                this.form = {}
                if (pid) {
                    this.form.pid = pid
                }
            }
        }
    }
</script>
