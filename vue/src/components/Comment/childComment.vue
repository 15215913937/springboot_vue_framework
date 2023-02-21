<template>
  <div class="comment-line-box" v-for="childComment in childComments">
    <div class="comment-list-item">
      <el-avatar icon="el-icon-user-solid" :size="35" style="width: 38px;"></el-avatar>
      <div class="right-box">
        <div class="new-info-box clearfix">
          <div class="comment-top">
            <div class="user-box">
              <span class="comment-name">{{ childComment.userName }}</span>
              <el-tag size="mini" type="danger" v-show="childComment.userName === event.authorName"
                      style="margin-left: 5px;">作者
              </el-tag>
              <span class="text">回复</span>
              <span class="nick-name">{{ parentComment.userName }}</span>
              <span class="date">{{ childComment.createTime }}</span>
              <div class="opt-comment">
                <i class="el-icon-delete"></i>
                <span style="margin-left: 3px;" @click="deleteComment(childComment)">删除</span>
                <i class="el-icon-chat-round" style="margin-left: 10px;"></i>
                <span style="margin-left: 3px;" @click="showReplay = !showReplay">回复</span>
              </div>
            </div>
          </div>
          <div class="comment-center">
            <div class="new-comment">{{ childComment.content }}</div>
          </div>
        </div>
      </div>
    </div>
    <!-- 回复框 -->
    <replay :rootParentId="rootParentId" :comment="childComment" :showReplay="showReplay" :eventId="eventId"
            :getCommentList="getCommentList" style="margin-top: 5px;"></replay>
    <!-- 嵌套递归 -->
    <child :childComments="childComment.child" :parentComment="childComment" :event="event" :rootParentId="rootParentId"
           :getCommentList="getCommentList"></child>
  </div>

</template>

<script>
export default {
  name: "childComment"
}
</script>

<style scoped>

</style>