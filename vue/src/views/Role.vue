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
            <el-input v-model="role" placeholder="请输入角色名称" style="width: 20%" class="mr-10" :prefix-icon="Search"
                      clearable/>
            <el-button class="mb-10" type="primary" @click="load">查询</el-button>
            <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
        </div>
        <!--    列表区-->
        <!--        stripe:斑马纹-->
        <el-table
                v-loading="loading"
                :data="tableData"
                border
                stripe
                style="width: 100%"
                @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"/>
            <!--            sortable:排序操作-->
            <el-table-column prop="id" label="ID" sortable=""/>
            <el-table-column prop="role" label="角色"/>
            <el-table-column prop="description" label="描述"/>
            <el-table-column fixed="right" label="操作" width="300px">
                <template #default="scope">
                    <el-button plain type="success" @click="selectMenu(scope.row.id)">
                        <el-icon>
                            <Menu/>
                        </el-icon>
                        分配菜单
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
            <el-dialog v-model="menuDialogVis" title="菜单分配" width="30%">
                <el-tree
                        :props="props"
                        :data="menuData"
                        node-key="id"
                        :default-expanded-keys="[2,5]"
                        :default-checked-keys="[2,5,7,8]"
                        show-checkbox
                        @check-change="handleCheckChange"
                />
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="menuDialogVis = false">取消</el-button>
                        <el-button type="primary" @click="save">提交</el-button>
                    </span>
                </template>
            </el-dialog>
            <el-dialog v-model="dialogVisible" title="角色信息" width="30%">
                <el-form model="form" label-width="120px">
                    <el-form-item label="角色">
                        <el-input v-model="form.role" style="width: 80%"/>
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

    export default {
        name: 'Role',
        components: {},
        data() {
            return {
                loading: true,
                form: {},
                menuDialogVis: false,
                dialogVisible: false,
                role: '',
                tableData: [],
                menuData: [],
                props: {
                    label: 'name',
                }
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
                request.get("/role/page").then(res => {
                    console.log(res);
                    this.loading = false;
                    this.tableData = res.data.records;
                });
            },
            reset() {
                this.role = '';
                this.load();
            },
            add() {
                this.dialogVisible = true;
                // 清空表单域，点击取消后，下次打开就是清空内容了
                this.form = {}
            },
            save() {
                if (this.form.id) {//若果id存在，更新
                    request.post("/role", this.form).then(res => {
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
                    request.post("/role", this.form).then(res => {
                        // console.log(res);
                        if (res.code === '0') {
                            this.$message.success("新增成功")
                        } else {
                            this.$message.error(res.msg)
                        }
                        this.load();//刷新表格数据
                        this.dialogVisible = false
                    });
                }
            },
            handleEdit(row) {
                this.form = JSON.parse(JSON.stringify(row));
                this.dialogVisible = true
            },
            handleDelete(row) {
                this.id = row.id
                // console.log(this.id);
                request.delete("/role/" + this.id).then(res => {
                    if (res.code === '0') {
                        this.$message.success("删除成功")
                    } else {
                        this.$message.error(res.msg)
                    }
                    this.load();//刷新表格数据
                })
            },
            selectMenu(roleId) {
                this.menuDialogVis = true;
                //请求菜单数据
                request.get("/menu", {
                    params: {
                        name:"",
                    }
                }).then(res => {
                    console.log(res);
                    this.loading = false;
                    this.menuData = res.data;
                })
            },
            handleCheckChange(data, checked, indeterminate) {
                console.log(data, checked, indeterminate);
            }
        }
    }
</script>
