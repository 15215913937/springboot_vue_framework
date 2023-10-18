<template>
  <div style="display: flex;padding: 10px;justify-content: center">
    <el-tag type="error" v-if="isTrading === 0">不在交易时间内</el-tag>
    <el-tag type="success" v-if="isTrading === 1">交易进行中...</el-tag>
  </div>

</template>

<script>
let interval;
let startHour = 9;
let startMinute = 30;
let endHour = 15;
let endMinute = 0;
export default {
  name: 'stock',
  data() {
    return {
      day: '',
      isTrading: 0
    }
  },
  created() {
    interval = setInterval(() => {
      let icnow = new Date();
      let currentHour = icnow.getHours();
      let currentMinute = icnow.getMinutes();

      this.day = icnow.getDay()
      if (icnow.getDay() !== 6 && icnow.getDay() !== 7) {
        if (currentHour > startHour ||
            (currentHour === startHour && currentMinute >= startMinute)) {

          if (currentHour < endHour ||
              (currentHour === endHour && currentMinute < endMinute)) {

            this.isTrading = 1

          } else {
            this.isTrading = 0
          }
        }
      } else {
        this.isTrading = 0
      }
    }, 1000)
  },
  beforeDestroy() {
    clearInterval(interval);
  }
}

</script>

<style scoped>

</style>