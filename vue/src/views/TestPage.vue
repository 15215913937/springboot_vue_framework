<template>
  <div class="form-container">
    <div class="form-field">
      <el-radio-group v-model="selectedOption">
        <el-radio label="合格">合格</el-radio>
        <el-radio label="不合格">不合格</el-radio>
      </el-radio-group>
    </div>
    <div class="form-field" v-if="selectedOption === '不合格' || selectedOption === '合格'">
      <label class="form-label">备注</label>
      <el-input
          type="textarea"
          :rows="4"
          placeholder="请输入备注"
          v-model="comment"
      ></el-input>
    </div>
    <div class="form-actions">
      <el-button type="primary" @click="submitForm">确认</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      selectedOption: '合格',
      comment: '',
    };
  },
  methods: {
    submitForm() {
      // 在这里处理提交表单的逻辑
      console.log(this.selectedOption);
      console.log(this.comment);
    },
  },
};
</script>

<style scoped>
.form-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 10px;
  margin-bottom: 20px;
}

.form-field {
  display: flex;
  align-items: center;
  gap: 10px;
}

.form-label {
  width: 80px;
}

.form-actions {
  text-align: center;
}
</style>