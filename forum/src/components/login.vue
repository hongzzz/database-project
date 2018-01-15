<template>
  <div class="login">
    <div class="wrapper">
      <h1 class="title">Forum</h1>
      <ul class="slider">
        <li @click="turn(0)" :class="{active:type}">登陆</li>
        <li @click="turn(1)" :class="{active:!type}">注册</li>
        <li ref="move" class="move"></li>
      </ul>
      <el-form v-show="type" :model="loginForm" ref="loginForm" :rules="loginRules" class="loginForm" label-width="70px"
               label-position="left" status-icon>
        <el-form-item label="账号" prop="username" class="form-item">
          <el-input type="text" v-model="loginForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" class="form-item">
          <el-input type="password" v-model="loginForm.password"></el-input>
        </el-form-item>
        <el-button type="primary" @click="submitLogin" class="login-button">登陆</el-button>
      </el-form>

      <el-form v-show="!type" :model="registerForm" ref="registerForm" :rules="registerRules" class="registerForm"
               label-width="70px" label-position="left" status-icon>
        <el-form-item label="账号" prop="username" class="form-item">
          <el-input type="text" v-model="registerForm.username"></el-input>
        </el-form-item>
        <el-form-item label="昵称" prop="nickname" class="form-item">
          <el-input type="text" v-model="registerForm.nickname"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" class="form-item">
          <el-input type="password" v-model="registerForm.password"></el-input>
        </el-form-item>
        <el-form-item label="再次输入" prop="password2" class="form-item">
          <el-input type="password" v-model="registerForm.password2"></el-input>
        </el-form-item>
        <el-button type="primary" @click="submitRegister" class="register-button">注册</el-button>
      </el-form>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      let checkUsername = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('请输入账号'))
        } else {
          callback()
        }
      }
      let checkPassword = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('请输入密码'))
        } else {
          callback()
        }
      }
      let checkPassword2 = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('请输入密码'))
        } else if (this.registerForm.password !== value) {
          return callback(new Error('两次输入不一致'))
        } else {
          callback()
        }
      }
      let checkNickname = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('请输入昵称'))
        } else {
          callback()
        }
      }
      return {
        type: true,
        loginForm: {
          username: '',
          password: ''
        },
        registerForm: {
          username: '',
          nickname: '',
          password: '',
          password2: ''
        },
        loginRules: {
          username: [
            {validator: checkUsername, trigger: 'blur'}
          ],
          password: [
            {validator: checkPassword, trigger: 'blur'}
          ]
        },
        registerRules: {
          username: [
            {validator: checkUsername, trigger: 'blur'}
          ],
          password: [
            {validator: checkPassword, trigger: 'blur'}
          ],
          password2: [
            {validator: checkPassword2, trigger: 'blur'}
          ],
          nickname: [
            {validator: checkNickname, trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      turn (num) {
        if (num === 0) {
          this.type = true
          this.$refs.move.style.left = 0 + 'px'
        } else if (num === 1) {
          this.type = false
          this.$refs.move.style.left = 50 + '%'
        }
      },
      submitLogin () {
        this.$refs.loginForm.validate((valid) => {
          if (valid) {
            this.$http.post('http://172.29.35.3:3000/login', this.loginForm)
              .then((response) => {
                if (response.data.errno === 0) {
                  this.$message.success('登陆成功')
                  this.$store.dispatch('login', response.data)
                  this.$router.push('/')
                } else if (response.data.errno === 1) {
                  this.$message.error('账号或者密码出错')
                } else if (response.data.errno === 2) {
                  this.$message('请不要重复登陆')
                } else {
                  this.$message.error('something wrong..')
                }
              })
              .catch((err) => {
                console.error(err)
                this.$message.error('账号或者密码出错')
              })
          } else {
            console.log('error submit!!')
            return false
          }
        })
      },
      submitRegister () {
        this.$refs.registerForm.validate((valid) => {
          if (valid) {
            this.$http.post('http://172.29.35.3:3000/register', this.registerForm)
              .then((response) => {
                if (response.data.errno === 0) {
                  this.$message.success('注册成功')
                  this.turn(0)
                } else {
                  this.$message.error(response.data.message)
                }
              })
              .catch((err) => {
                console.error(err)
              })
          } else {
            console.log('error submit!!')
            return false
          }
        })
      }
    }
  }
</script>

<style scoped lang="scss">
  .login {
    width: 100%;
    height: 100%;
    background: #409eff;
    .wrapper {
      position: relative;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      width: 80%;
      height: 75%;
      max-width: 500px;
      background: #fff;
      border-radius: 10px;
      .title {
        text-align: center;
        font-weight: normal;
        font-size: 50px;
        margin: 0;
        padding-top: 30px;
      }
      .slider {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0);
        width: 40%;
        height: 30px;
        margin: 20px 0 20px 0;
        padding: 0;
        list-style: none;
        font-size: 0;
        li {
          display: inline-block;
          width: 50%;
          height: 30px;
          text-align: center;
          font-size: 15px;
          cursor: pointer;
          &.active {
            color: #409EFF;
          }
          &.move {
            position: absolute;
            left: 0;
            top: 100%;
            height: 0;
            border-bottom: solid 4px #409EFF;
            transition: 0.2s all linear;
          }
        }
      }
      .loginForm {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0);
        width: 70%;
        height: 65%;
        margin-top: 80px;
        .form-item {
          margin-bottom: 40px;
        }
        .login-button {
          width: 100%;
        }
      }
      .registerForm {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0);
        width: 70%;
        height: 65%;
        margin-top: 30px;
        .register-button {
          margin-top: 10px;
          width: 100%;
        }
      }
    }
  }
</style>
