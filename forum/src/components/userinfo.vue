<template>
  <div class="userinfo">
    <div class="container">
      <i class="close el-icon-close" @click="hideInfo"></i>
      <el-form :model="userForm" class="content">
        <h2 class="profile">Profile</h2>
        <el-form-item label="username">
          <el-input v-model="user.username" disabled auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="nickname">
          <el-input v-model="userForm.nickname" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="email">
          <el-input v-model="userForm.email" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="sex">
          <el-radio-group v-model="userForm.sex">
            <el-radio label="1">男</el-radio>
            <el-radio label="0">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-button type="primary" @click="changeUserInfo" class="submit-button">确认修改</el-button>
      </el-form>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      user: {
        type: Object
      }
    },
    data () {
      return {
        userForm: {
          nickname: this.user.nickname,
          email: this.user.email,
          sex: this.user.sex + ''
        }
      }
    },
    methods: {
      hideInfo () {
        this.userForm = {
          nickname: this.user.nickname,
          email: this.user.email,
          sex: this.user.sex + ''
        }
        this.$emit('hide')
      },
      changeUserInfo () {
        this.userForm.uid = this.user.uid
        this.$http.post('http://172.29.35.3:3000/changeuserinfo', this.userForm)
          .then((response) => {
            this.$emit('refresh', response.data)
            this.$message({
              message: '修改成功',
              type: 'success'
            })
          })
          .catch((err) => {
            console.log(err)
          })
      }
    }
  }
</script>

<style lang="scss">
  .userinfo {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    background: rgba(13, 23, 33, 0.4);
    z-index: 10;
    .container {
      position: relative;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      width: 40%;
      height: 80%;
      background: #fff;
      .close {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 40px;
        height: 40px;
        color: #aaa;
        font-size: 30px;
        text-align: center;
        line-height: 40px;
        &:hover {
          color: #888;
        }
      }
      .profile {
        text-align: center;
        font-weight: 400;
      }
      .content {
        margin-top: 60px;
        padding: 0 80px 0 80px;
        .submit-button {
          margin: 0;
          width: 100%;
        }
      }

    }
  }
</style>
