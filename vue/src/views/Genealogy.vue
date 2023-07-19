<template>
  <div style="padding: 10px">
    <div style="width: 100%;height: 90%;">
      <G6Tree v-if="treedata.downstreamName" :treedata="treedata" @deleteBlood='deleteBlood'></G6Tree>
    </div>
    <div>
    aa
    </div>
  </div>
</template>
<script>
import G6Tree from "@/components/Comment/G6Tree";

export default {
  components: {
    G6Tree,
  },
  data() {
    return {
      treedata: {},
    };
  },
  mounted() {
    this.getTree()
  },
  methods: {
    // 获取树节点
    getTree() {
      //调用获取节点的接口
      //数据中id必须为字符串类型，
      this.treedata = {
        downstreamName: "中心节点",
        upriverName: "中心节点",
        fixed: true, //是否固定 （固定则不显示删除按钮）
        children: [
          {
            id: "1",
            upriverName: "节点1",
            direction: "right",//展示在中心节点的左边或者右边
            children: [
              {
                id: "2",
                upriverName: "节点1-1",
                direction: "right",
                children: []
              },
              {
                id: "3",
                upriverName: "节点1-2",
                direction: "right",
                children: []
              },
            ],
          },
          {
            id: "4",
            upriverName: "节点2",
            direction: "right",
            children: [
              {
                id: "5",
                upriverName: "节点2-1",
                direction: "right",
                children: []
              },
              {
                id: "6",
                upriverName: "节点2-2",
                direction: "right",
                children: []
              },
            ],
          },
          {
            id: "7",
            downstreamName: "节点3",
            direction: "left",
            children: [
              {
                id: "8",
                downstreamName: "节点3-1",
                direction: "left",
                children: []
              },
              {
                id: "9",
                downstreamName: "节点3-2",
                direction: "left",
                children: []
              },
            ],
          },
          {
            id: "10",
            downstreamName: "节点4",
            direction: "left",
            children: [
              {
                id: "11",
                downstreamName: "节点4-1",
                direction: "left",
                children: [
                  {
                    id: "12",
                    downstreamName: "节点4-1-1",
                    direction: "left",
                    children: []
                  },
                  {
                    id: "13",
                    downstreamName: "节点4-1-2",
                    direction: "left",
                    children: []
                  },
                ],
              },
            ],
          },
        ],
      }
    },
    // 删除节点
    deleteTreeNode(id) {
      const param = {id: id}
      //调用删除接口
      api.deleteTreeNode(param)
          .then((res) => {
            if (res.data && res.data.code == 200) {
              this.msgSuccess("删除节点成功");
            }
          })
          .catch((err) => {
            this.$message.error(err);
            console.log(err);
          });
    },
  },
};
</script>