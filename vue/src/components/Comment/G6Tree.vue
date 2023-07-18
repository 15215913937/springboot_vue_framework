<template>
  <div>
    <div id="container" :style="{ height: '400px', width: '100%' }" />
  </div>
</template>

<script>
import G6 from '@antv/g6'
export default {
  data() {
    return {
      graph: undefined,
    };
  },
  props:{
    treedata:{
      type:Object
    }
  },
  watch:{
    "treedata":{
      handler:function(cur,old){
        if(cur != old){
          this.refresh();
        }
      },
      deep:true,	//对象内部的属性监听，也叫深度监听
      // immediate:true
    }
  },
  mounted() {
    this.$nextTick(()=>{
      if(this.treedata.downstreamName){
        this.showChart(this.treedata);
        this.$forceUpdate()
      }
    })

  },
  methods: {
    refresh() {
      if (this.graph){
        //销毁方法
        this.graph.destroy();
      }
      //重新实例化
      this.showChart();
      this.$forceUpdate()
    },
    showChart() {
      //为了更明显的展示颜色 配色不好看 别介意哈
      const that = this
      G6.registerNode(
          "tree-node",
          {
            drawShape: function drawShape(cfg, group) {
              const rect = group.addShape("rect", {
                // 节点框样式
                attrs: {
                  fill: "blue",//节点框蓝色背景色
                  // stroke: "red",
                  x: 0,
                  y: 0,
                  width: 1,
                  height: 1,
                  radius: [12],
                },
                name: "rect-shape",
              });
              //upriverName代表节点上游，downstreamName代表节点下游（后端的数据就是这样，所以我这样写）其实不分上下游直接用name也是可以的
              const content = cfg.downstreamName||cfg.upriverName;
              const text = group.addShape("text", {
                // 节点文字样式
                attrs: {
                  text: content,
                  x: 0,
                  y: 0,
                  textAlign: "left",
                  textBaseline: "middle",
                  fill: "white",//节点框内白色文字
                },
                name: "text-shape",
              });
              const bbox = text.getBBox();
              const hasChildren = cfg.children && cfg.children.length > 0;
              rect.attr({
                x:-20,
                y:-15,
                width:170, //节点框的宽度
                height:27,
                textAlign:"left"
              });
              // 文字的位置
              text.attr({
                //   x: -bbox.width / 2 + 15,
                //   y: 2,
                x: 0,
                y:0,
              });
              // 展开折叠图标样式
              if (hasChildren) {
                group.addShape("marker", {
                  attrs: {
                    //   x: bbox.width / 2 + 24,
                    //   y: 0,
                    x: 150,
                    y: 0,
                    r: 6,
                    symbol: cfg.collapsed ? G6.Marker.expand : G6.Marker.collapse,
                    stroke: "#fff",
                    fill: "green",//绿色删除按钮
                    lineWidth: 1,
                  },
                  name: "collapse-icon",
                });
              }

              // 加一个删除按钮
              const deleImage = group.addShape('image', {
                attrs: {
                  x: -15,
                  y:  bbox.height / 2 -13,
                  img: cfg.fixed?'':require('@/assets/dele.png'),
                  width: bbox.height,
                  height: bbox.height,
                  cursor: 'pointer'
                },
                name: 'deleteItem'
              })
              return rect;
            },
            update: (cfg, item) => {
              const group = item.getContainer();
              const icon = group.find((e) => e.get("name") === "collapse-icon");
              icon.attr(
                  "symbol",
                  cfg.collapsed ? G6.Marker.expand : G6.Marker.collapse
              );
            },
          },
          "single-node"
      );

      const container = document.getElementById("container");
      const width = container.scrollWidth;
      const height = container.scrollHeight || 500;
      const graph = new G6.TreeGraph({
        container: "container",
        width,
        height,
        modes: {
          default: [
            {
              type: "collapse-expand",
              onChange: function onChange(item, collapsed) {
                const data = item.get("model");
                graph.updateItem(item, {
                  collapsed,
                });
                data.collapsed = collapsed;
                return true;
              },
            },
            "drag-canvas",
            "zoom-canvas",
          ],
        },
        defaultNode: {
          type: "tree-node",
          anchorPoints: [
            [0, 0.5],
            [1, 0.5],
          ],
        },
        // 节点连接线样式
        defaultEdge: {
          type: "cubic-horizontal",
          style: {
            stroke: "#9fb1f8",
          },
        },
        layout: {
          type: "compactBox",
          direction: "H",
          // 判断节点向左展开还是向右展开
          getSide: (d) => {
            if (d.data.direction == 'right') {
              return 'right';
            }
            return 'left';
          },
          getId: function getId(d) {
            return d.id+"";
          },
          getHeight: function getHeight() {
            return 16;
          },
          // 节点框和线的宽度
          getWidth: function getWidth() {
            return 70;
          },
          getVGap: function getVGap() {
            return 20;
          },
          getHGap: function getHGap() {
            return 60;
          },
        },
      });
      this.graph = graph
      graph.on('deleteItem:click',(ev)=>{
        const node = ev.item
        const data= node.getModel()
        that.$confirm('是否确认删除?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          if(data.downstreamTable){
            this.$emit("deleteBlood",data.id)
          }else{
            this.$emit("deleteBlood",data.id)
          }
        }).catch(() => {
          that.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
      })
      graph.data(this.treedata);
      graph.render();
      graph.fitCenter();
      // graph.fitView();
      if (typeof window !== "undefined")
        window.onresize = () => {
          if (!graph || graph.get("destroyed")) return;
          if (!container || !container.scrollWidth || !container.scrollHeight)
            return;
          graph.changeSize(container.scrollWidth, container.scrollHeight);
        };
    },
  },
};
</script>

<style scoped>
#nodeDetails {
  list-style: none;
  background-color: blue;
}
#nodeDetails > li {
  padding: 5px 0;
  text-align: left;
  background-color: #ebeefd;
}
::v-deep .g6-component-tooltip {
  background-color: #ccc;
}
.nodeClass {
  padding: 10px;
}
</style>