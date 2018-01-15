<template>
  <div class="topic">
    <div class="block" v-for="topic in topics" @click="getReplies(topic)">
      <h3 class="title">{{topic.title}}</h3>
      <span class="time">{{topic.updatetime | formatDate}}</span>
      <p class="content">{{topic.content}}&nbsp</p>
      <span class="count">{{topic.replycount}} replies</span>
      <div class="user">
        <img :src="topic.avatar" class="avatar">
        <span class="name">{{topic.nickname}}</span>
      </div>
    </div>
  </div>
</template>

<script>
  import {formatDate} from '../utils/formatDate'

  export default {
    data () {
      return {}
    },
    props: {
      topics: {
        type: Array
      }
    },
    filters: {
      formatDate (time) {
        let date = new Date(time)
        return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
      }
    },
    methods: {
      getReplies (topic) {
        this.$emit('getreplies', topic)
      }
    }
  }
</script>

<style lang="scss">
  .topic {
    box-sizing: border-box;
    width: 100%;
    padding: 20px;
    font-weight: 300;
    .block {
      position: relative;
      padding: 30px 50px;
      margin-bottom: 10px;
      border-radius: 10px;
      background: #eee;
      cursor: pointer;
      &:hover {
        background: #ddd;
        .title {
          color: #5C5CA6;
        }
      }
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
    }
  }
</style>
