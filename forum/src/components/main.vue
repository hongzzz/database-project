<template>
  <div class="main">
    <el-header class="header">
      <div class="trademark">Forum</div>
      <div class="profile">
        <el-dropdown placement="bottom-start" @command="handleProfile">
          <span class="el-dropdown-link">
            <img width="40" height="40" :src="user.avatar" alt="img" class="avatar">
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="a">Profile</el-dropdown-item>
            <el-dropdown-item command="b">Log out</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </el-header>
    <el-main class="container">
      <el-button type="primary" icon="el-icon-arrow-left" class="back" v-show="showSession">Back</el-button>
      <el-button type="primary" icon="el-icon-arrow-left" class="back" v-show="showTopic" @click="backToSession">Back
      </el-button>
      <el-button type="primary" icon="el-icon-arrow-left" class="back" v-show="showReply" @click="backToTopic">Back
      </el-button>
      <el-button type="primary" icon="el-icon-plus" class="add" v-show="showTopic" @click="showDialog">Add</el-button>
      <session :sessions="sessions" v-show="showSession" @gettopics="getTopics"></session>
      <topic :topics="topics" :currentSession="currentSession" @getreplies="getReplies" @refresh_topic="refreshTopics"
             v-show="showTopic"></topic>
      <reply :replies="replies" :currentTopic="currentTopic" v-show="showReply" @refresh_reply="refreshReplies"></reply>
      <el-dialog title="Add Topic" :visible.sync="showdialog">
        <el-form :model="topicForm">
          <el-form-item label="Topic Title">
            <el-input v-model="topicForm.title" auto-complete="off"></el-input>
          </el-form-item>
          <el-form-item label="Topic Content">
            <el-input type="textarea" :rows="5" v-model="topicForm.content" auto-complete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="showdialog = false">取 消</el-button>
          <el-button type="primary" @click="addTopic">确 定</el-button>
        </div>
      </el-dialog>
    </el-main>
    <userinfo v-show="showUserInfo" :user="user" @hide="showUserInfo=false" @refresh="refreshUser"></userinfo>
  </div>
</template>

<script>
  import topic from './topic'
  import session from './session'
  import reply from './reply'
  import userinfo from './userinfo'

  export default {
    components: {
      topic,
      session,
      reply,
      userinfo
    },
    data () {
      return {
        user: this.$store.state.user,
        sessions: [],
        topics: [],
        replies: [],
        topicForm: {
          sid: 0,
          uid: 0,
          title: '',
          content: ''
        },
        currentTopic: {},
        currentSession: {},
        currentsid: 0,
        currenttid: 0,
        showSession: true,
        showUserInfo: false,
        showTopic: false,
        showReply: false,
        showdialog: false
      }
    },
    methods: {
      handleProfile (command) {
        if (command === 'a') {
          this.showUserInfo = true
        }
        if (command === 'b') {
          this.logout()
        }
      },
      logout () {
        this.$http.post('http://172.29.35.3:3000/logout', {username: this.user.username})
          .then((response) => {
            this.$store.dispatch('logout').then(() => {
              this.$router.push('/login')
              this.$message({
                message: '注销成功',
                type: 'success'
              })
            })
          })
          .catch((err) => {
            console.log(err)
          })
      },
      getSessions () {
        this.$http.post('http://172.29.35.3:3000/getsession')
          .then((response) => {
            this.sessions = response.data
          })
          .catch((err) => {
            console.log(err)
          })
      },
      getTopics (session) {
        this.$http.post('http://172.29.35.3:3000/gettopic', {sid: session.sid})
          .then((response) => {
            this.currentsid = session.sid
            this.topics = response.data
            this.showTopic = true
            this.showSession = false
            console.log(this.topics)
          })
          .catch((err) => {
            console.log(err)
          })
      },
      getReplies (topic) {
        this.$http.post('http://172.29.35.3:3000/getreply', {tid: topic.tid})
          .then((response) => {
            this.replies = response.data
            this.currentTopic = topic
            this.currenttid = topic.tid
            this.showTopic = false
            this.showReply = true
          })
          .catch((err) => {
            console.log(err)
          })
      },
      refreshReplies () {
        this.$http.post('http://172.29.35.3:3000/getreply', {tid: this.currenttid})
          .then((response) => {
            this.replies = response.data
          })
          .catch((err) => {
            console.log(err)
          })
        this.$http.post('http://172.29.35.3:3000/gettopic', {sid: this.currentsid})
          .then((response) => {
            this.topics = response.data
            for (let t of this.topics) {
              if (t.tid === this.currenttid) {
                this.currentTopic = t
              }
            }
          })
          .catch((err) => {
            console.log(err)
          })
        this.getSessions()
      },
      refreshTopics () {
        this.$http.post('http://172.29.35.3:3000/gettopic', {sid: this.currentsid})
          .then((response) => {
            this.topics = response.data
            console.log(this.topics)
          })
          .catch((err) => {
            console.log(err)
          })
        this.getSessions()
      },
      addTopic () {
        this.topicForm.sid = this.currentsid
        this.topicForm.uid = this.user.uid
        this.$http.post('http://172.29.35.3:3000/addtopic', this.topicForm)
          .then((response) => {
            if (response.data.errno === 0) {
              this.$message({
                message: '成功',
                type: 'success'
              })
              this.$http.post('http://172.29.35.3:3000/gettopic', {sid: this.currentsid})
                .then((response) => {
                  this.topics = response.data
                })
                .catch((err) => {
                  console.log(err)
                })
            }
          })
          .catch((err) => {
            console.log(err)
          })
        this.showdialog = false
      },
      refreshUser (data) {
        this.user = data
      },
      showDialog () {
        this.showdialog = true
      },
      backToSession () {
        this.showTopic = false
        this.showSession = true
      },
      backToTopic () {
        this.showTopic = true
        this.showReply = false
      }
    },
    created () {
      this.getSessions()
    }
  }
</script>

<style lang="scss">
  .main {
    height: 100%;
    .header {
      background: #409eff;
      .trademark {
        position: absolute;
        left: 25px;
        height: 60px;
        color: #fff;
        font-size: 25px;
        text-align: center;
        line-height: 60px;
      }
      .profile {
        position: absolute;
        right: 20px;
        width: 50px;
        height: 50px;
        margin: 5px;
        .avatar {
          margin: 5px;
          border-radius: 50%;
        }
      }
    }
    .container {
      position: absolute;
      top: 60px;
      bottom: 0;
      left: 0;
      right: 0;
      overflow: auto;
      button {
        margin-left: 10px;
      }
    }
  }
</style>
