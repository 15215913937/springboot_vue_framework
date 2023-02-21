<template>
  <div class="comment-list-container">
    <div class="comment-list-box comment-operate-item">
      <ul class="comment-list" v-for="comment in commentList">
        <!-- 评论根目录 -->
        <root :comment="comment" :event="event" :getCommentList="getCommentList"></root>
        <!-- 评论子目录 -->
        <li class="replay-box" style="display: block;">
          <ul class="comment-list">
            <!-- 子组件递归实现 -->
            <child :childComments="comment.child" :parentComment="comment" :event="event" :rootParentId="comment.id"
                   :getCommentList="getCommentList" v-if="comment.child != null"></child>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "CommentDetails"
}
</script>

<style scoped>

</style>