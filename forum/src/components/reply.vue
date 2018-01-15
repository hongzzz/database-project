<template>
  <div class="reply">
    <div class="block topic">

      <h3 class="title">{{currentTopic.title}}</h3>
      <span class="time">{{currentTopic.updatetime | formatDate}}</span>
      <p class="content">{{currentTopic.content}}&nbsp</p>
      <span class="count">{{currentTopic.replycount}} replies</span>
      <div class="user">
        <img :src="currentTopic.avatar" class="avatar">
        <span class="name">{{currentTopic.nickname}}</span>
      </div>
    </div>

    <div class="note">Replies:</div>

    <div class="block reply" v-for="reply in replies">
      <div class="user">
        <img :src="reply.avatar" class="avatar">
        <span class="name">{{reply.nickname}}</span>
      </div>
      <span class="time">{{reply.createtime | formatDate}}</span>
      <p class="content">{{reply.content}}</p>
    </div>

    <div class="note">Add Reply:</div>

    <div class="block">
      <el-input type="textarea" v-model="replyForm.content" :rows="7" class="text"></el-input>
      <el-button type="primary" @click="addReply" class="submit-button">Reply</el-button>
    </div>

  </div>
</template>

<script>
  import {formatDate} from '../utils/formatDate'

  export default {
    props: {
      currentTopic: {
        type: Object
      },
      replies: {
        type: Array
      }
    },
    filters: {
      formatDate (time) {
        let date = new Date(time)
        return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
      }
    },
    data () {
      return {
        replyForm: {
          content: '',
          uid: '',
          tid: ''
        }
      }
    },
    methods: {
      addReply () {
        this.replyForm.uid = this.$store.state.user.uid
        this.replyForm.tid = this.currentTopic.tid
        console.log(this.replyForm)
        this.$http.post('http://172.29.35.3:3000/addreply', this.replyForm)
          .then((response) => {
            if (response.data.errno === 0) {
              this.$message.success('评论成功')
              this.replyForm.content = ''
              this.$emit('refresh_reply')
            } else {
              this.$message.error('出错了')
            }
          })
          .catch((err) => {
            console.error(err)
          })
      }
    }
  }
</script>

<style lang="scss">
  .reply {
    box-sizing: border-box;
    width: 100%;
    padding: 20px;
    font-weight: 300;
    .block {
      position: relative;
      padding: 30px 50px;
      border-radius: 10px;
      background: #eee;
      cursor: pointer;
      .title {
        margin: 0;
        color: #0074a3;
        max-width: 400px;
        min-width: 100px;
        word-wrap: break-word;
        font-weight: normal;
      }
      .time {
        position: absolute;
        right: 50px;
        top: 35px;
      }
      .count {
        color: #777;
      }
      .user {
        position: absolute;
        right: 55px;
        bottom: 38px;
        .avatar {
          width: 40px;
          margin-right: 10px;
          border-radius: 50%;
        }
        .name {
          line-height: 40px;
          vertical-align: top;
        }
      }
      .submit-button {
        margin: 25px 0 0 0;
        width: 100%;
      }
      .text {
        margin-top: 10px;
        textarea {
          resize: none;
          overflow: auto;
        }
      }
      &.reply {
        margin-bottom: 10px;
        .user {
          display: inline-block;
          position: relative;
          top: 0;
          left: 0;
        }
      }
    }
    .note {
      margin: 45px 0 15px 0;
    }
  }
</style>
