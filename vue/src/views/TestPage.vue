<template>
  <div>
    <button @click="openPreview">预览图片</button>
    <div v-if="showPreview">
      <div class="overlay"></div>
      <div class="preview-modal">
        <img :src="imageUrl" alt="预览图片" />
        <button @click="closePreview">关闭</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showPreview: false,
      imageUrl: "http://localhost:9090/files/test/535af625316748d5b24bcd9a4b90482a.jpg"
    };
  },
  methods: {
    openPreview() {
      this.showPreview = true;
    },
    closePreview() {
      this.showPreview = false;
    }
  }
};
</script>

<style>
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 9999;
}

.preview-modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
  padding: 20px;
  z-index: 10000;
}

.preview-modal img {
  max-width: 100%;
  max-height: 80vh;
}

.preview-modal button {
  margin-top: 10px;
}
</style>
