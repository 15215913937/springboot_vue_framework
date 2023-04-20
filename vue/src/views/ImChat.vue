<template>
  <div style="padding: 10px;margin-bottom: 50px">
    <el-row>
      <el-col :span="4">
        <el-card style="width: 300px;height: 300px;color: #333333">
          <div style="padding-bottom: 10px;border-bottom: 1px solid #ccc">
            在线用户
            <span style="font-size: 12px">
              （点击聊天气泡开始聊天）
            </span>
          </div>
          <div style="padding:10px 0" v-for="user in users" :key="user.username">
            <span>
              {{ user.username }}
            </span>
            <el-icon style="margin-left: 10px;font-size: 16px;cursor: pointer"
                     @click="chatUser=user.username"><ChatDotSquare /></el-icon>
            <span style="font-size: 12px;color: limegreen;margin-left: 5px" v-if="user.username ===chatUser">
              chatting...
            </span>
          </div>
        </el-card>
      </el-col>

      <el-col :span="20">
        <div
            style="width: 800px;margin: 0 auto;background-color: white;border-radius: 5px;box-shadow: 0 0 10px #cccccc">
          <div style="text-align: center;line-height: 50px">
            沈家聊天室 ( {{ chatUser }} )
          </div>
          <div style="height: 350px;overflow: auto;border-top: 1px solid #ccc" v-html="content"></div>
          <div style="height: 200px">
              <textarea v-model="text" style="height: 160px;width: 100%;padding-bottom: 20px;border: none;border-top: 1px solid #ccc;
border-bottom: 1px solid #ccc;outline: none"></textarea>
            <div style="text-align: right;padding-right: 10px">
              <el-button type="primary" size="mini" @click="send">发送</el-button>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import request from "@/utils/request";
import {ChatDotSquar} from "@element-plus/icons-vue";
let socket;

export default {
  name: "ImChat",
  data() {
    return {
      circleUrl: '',
      user: {},
      isCollapse: false,
      users: [],
      chatUser: '',
      text: "",
      messages: [],
      content: ''
    }
  },
  created() {
    this.init();
  },
  methods: {
    send() {
      if (!this.chatUser) {
        this.$message({type: 'warning ', message: "请选择聊天对象"})
        return;
      }
      if (!this.text) {
        this.$message({type: 'warning ', message: "请输入内容"})
      } else {
        if (typeof (WebSocket) == "undefined") {
          console.log("您的浏览器不支持WebSocket");
        } else {
          console.log("您的浏览器支持WebSocket");
          // 组装待发送的消息json
          // {"from":"sqn","to":"sqy","text":"hello"}
          let message = {from: this.user.username, to: this.chatUser, text: this.text}
          // 将消息发送给服务端，由服务端进行转发
          socket.send(JSON.stringify(message));
          this.messages.push({user: this.user.username, text: this.text})
          // 构建消息内容，本人消息
          this.createContent(null, this.user.username, this.text)
          this.text = '';
        }
      }
    },

    init() {
      this.user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {};
      let username = this.user.username;
      let _this = this;
      if (typeof (WebSocket) == "undefined") {
        console.log("您的浏览器不支持WebSocket");
      } else {
        console.log("您的浏览器支持WebSocket");
        let socketUrl = "ws://localhost:9090/imserver/" + username;
        if (socket != null) {
          socket.close();
          socket = null;
        }
        // 开启一个websocket服务
        socket = new WebSocket(socketUrl);
        // 打开事件
        socket.onopen = (() => {
          console.log("websocket已打开");
        });
        // 客户端接收消息，获取从服务端发送过来的消息
        socket.onmessage = ((msg) => {
          console.log("收到数据====" + msg.data);
          // 对接收到的json数据进行解析
          let data = JSON.parse(msg.data);
          if (data.users) {
            // 筛选出与当前用户不同的其他用户
            _this.users = data.users.filter(user => user.username !== username);
          } else {
            if (data.from === _this.chatUser) {
              _this.messages.push(data);
              // 构建消息内容
              _this.createContent(data.from, null, data.text);
            }
          }
        });

        // 关闭事件
        socket.onclose = (() => {
          console.log("websocket已关闭");
        })
        // 发生了错误事件
        socket.onerror = (() => {
          console.log("websocket发生了错误");
        })
      }
    },
    createContent(remoteUser, nowUser, text) {
      let html;
      // 当前用户消息
      if (nowUser) {
        html = "<div class=\"el-row\" style=\"padding: 5px 0\">\n" +
            "<div class=\"el-col el-col-22\" style=\"text-align: right; padding-right: 10px\">\n" +
            "<div class=\"tip left\">" + text + "</div>\n" +
            "</div>\n" +
            "<div class=\"el-col el-col-2\">\n" +
            "<span class=\"el-avatar el-avatar--circle\" style=\"height: 40px; width: 40px;line-height: 40px;\">\n" +
            "<img src=\"https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png\" style=\"object-fit : cover;\">\n" +
            "</span>\n" +
            "</div>\n" +
            "</div>";
      } else {
        html = "<div class=\"el-row\" style=\"padding: 5px 0\">\n" +
            "<div class=\"el-col el-col-2\" style=\"text-align: right\">\n" +
            "<span class=\"el-avatar el-avatar--circle\" style=\"height: 40px; width: 40px;line-height: 40px;\">\n" +
            "<img src=\"https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png\" style=\"object-fit : cover;\">\n" +
            "</span>\n" +
            "</div>\n" +
            "<div class=\"el-col el-col-22\" style=\"text-align: left; padding-left: 10px\">\n" +
            "<div class=\"tip right\">" + text + "</div>\n" +
            "</div>\n" +
            "</div>";
      }
      console.log(html);
      this.content += html;
    }
  }
}
</script>

<style scoped>
tip {
  color: white;
  text-align: center;
  border-radius: 10px;
  font-family: sans-serif;
  padding: 10px;
  width: auto;
  display: inline-block !important;
  display: inline;
}

.right {
  background-color: deepskyblue;
}

.left {
  background-color: forestgreen;
}
</style>