<template>
  <div style="padding: 10px">
    <!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">
        <el-icon>
          <CirclePlus/>
        </el-icon>
        &nbsp新增消费记录
      </el-button>
    </div>
    <!--    搜索区-->
    <div style="margin: 10px 0;display: block;clear: both">
      <el-select v-model="category" style="width: 15%;bottom: 2px" class="mr-10" placeholder="选择消费类别" clearable>
        <el-option
            v-for="item in categories"
            :key="item.id"
            :label="item.category"
            :value="item.category"
        />
      </el-select>
      <el-select v-model="type" style="width: 15%;bottom: 2px" class="mr-10" placeholder="选择类型" clearable>
        <el-option
            v-for="item in types"
            :key="item.id"
            :label="item.type"
            :value="item.type"
        />
      </el-select>

      <el-button class="mb-10" type="primary" @click="load">查询</el-button>
      <el-button class="mb-10" type="primary" @click="reset">重置</el-button>
    </div>
    <!--    列表区-->
    <!--        stripe:斑马纹-->
    <el-table
        v-loading="loading"
        :data="tableData"
        :header-cell-style="{'text-align':'center'}"
        border
        stripe
        style="width: 100%">
      <el-table-column prop="cost" label="费用" align="center"/>
      <el-table-column prop="category" label="消费类别" align="center"/>
      <el-table-column prop="type" label="类型" align="center">
        <template #default="scope">
          <el-tag type="error" v-if="scope.row.type === '支出'">支出</el-tag>
          <el-tag type="primary" v-if="scope.row.type === '收入'">收入</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createtime" label="创建时间" align="center"/>
      <el-table-column prop="comment" label="备注" align="center"/>
      <el-table-column fixed="right" label="操作" width="300px" align="center">
        <template #default="scope">
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
    <!--    新增窗口-->
    <el-dialog v-model="dialogVisible" title="新增消费记录" width="30%">
      <el-form :model="form" label-width="120px" :rules="rules" ref="pass">
        <el-form-item label="费用" prop="cost">
          <el-input v-model="form.cost" style="width: 80%" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="消费类别" prop="category">
          <el-select v-model="form.category" clearable placeholder="选择消费类别" style="width: 80%">
            <el-option
                v-for="item in categories"
                :key="item.id"
                :label="item.category"
                :value="item.category"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-radio v-model="form.type" label="支出" size="large">支出</el-radio>
          <el-radio v-model="form.type" label="收入" size="large">收入</el-radio>
        </el-form-item>
        <el-form-item label="备注" prop="comment">
          <el-input type="textarea" v-model="form.comment" style="width: 80%" autocomplete="off"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save" :loading="loading">提交</el-button>
        </span>
      </template>
    </el-dialog>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50]"
          :small="small"
          :disabled="disabled"
          :background="background"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script>
import request from '@/utils/request'

export default {
  name: "wallet",
  created() {
    this.load();
  },
  data() {
    return {
      currentPage: 1,
      pageSize: 10,
      total: 0,
      loading: false,
      tableData: [],
      nid: '',
      form: {
        uid: '',
        type: '支出'
      },
      category: '',
      type: '',
      categories: [],
      types: [],
      dialogVisible: false,
      user: sessionStorage.getItem('user') ? JSON.parse(sessionStorage.getItem('user')) : {},
    }
  },
  methods: {
    add() {
      this.dialogVisible = true;
      this.form = {};
      this.form.type = '支出'
      this.form.uid = this.user.id
    },
    load() {
      // console.log(this.category + ";" + this.type)
      request.get("/consumer-details/page", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          type: this.type,
          category: this.category,
          uid: this.user.id,
        }
      }).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.tableData = res.data.records;
          this.total = res.data.total;
        } else {
          this.$message.error(res.msg)
        }
      })
      request.get("/consumption-type").then(res => {
        this.types = res.data
      })
      request.get("/consumption-category").then(res => {
        this.categories = res.data
      })

    },
    reset() {
      this.category = '';
      this.type = '';
      this.load();
    },
    handleDelete(one) {
      request.delete("/consumer-details/" + one.id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
          this.load();
        } else {
          this.$message.error(res.msg);
        }
      })
    },
    save() {
      console.log(this.form)
      this.loading = true;
      request.post("/consumer-details", this.form).then(res => {
        setTimeout(() => {
          this.loading = false;
        }, 1000)
        if (res.code === '0') {
          this.$message.success("提交成功")
          this.load();
        } else {
          this.$message.error(res.msg)
        }
        this.dialogVisible = false
      })
    },
    handleSizeChange() {
      //改变当前每页个数的触发
      this.load()
    },
    handleCurrentChange() {
      //改变当前页数的触发
      this.load()
    },
  }
}
</script>

<style scoped>

</style>