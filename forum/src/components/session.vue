<template>
  <div class="session">
    <ul class="tb-head">
      <li>Sessions</li>
      <li>Topics</li>
      <li>Replies</li>
      <li>LastUpdate</li>
    </ul>
    <ul v-for="session in sessions">
      <li class="session-name" @click="getTopics(session)">{{session.sname}}</li>
      <li>{{session.topics}}</li>
      <li>{{session.replies}}</li>
      <li>{{session.updatetime | formatDate}}</li>
    </ul>
  </div>
</template>

<script>
  import {formatDate} from '../utils/formatDate'

  export default {
    data () {
      return {}
    },
    props: {
      sessions: {
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
      getTopics (session) {
        this.$emit('gettopics', session)
      }
    }
  }
</script>

<style lang="scss">
  .session {
    margin-top: 10px;
    padding: 20px;
    box-sizing: border-box;
    width: 100%;
    ul {
      display: block;
      list-style: none;
      font-size: 0;
      margin: 0;
      padding: 0;
      width: 100%;
      &.tb-head {
        background: #f2f2f2;
        border-top: 1px solid #ddd;
        border-bottom: 2px solid #409eff;
        li {
          font-size: 17px;
        }
      }
      li {
        display: inline-block;
        width: 25%;
        height: 60px;
        line-height: 60px;
        font-size: 15px;
        vertical-align: middle;
        text-align: center;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        &.session-name {
          color: #0074a3;
          cursor: pointer;
          &:hover {
            color: #5C5CA6;
          }
        }
      }
    }
  }
</style>
