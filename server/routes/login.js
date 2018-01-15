const router = require('koa-router')()
const check = require('../utils/check')

router.prefix('/login')

/**
 * errno===0 登陆成功
 * errno===1 账号密码有误
 * errno===2 已经登陆
 */

router.post('/', async (ctx, next) => {
  let result = {}
  let {username, password} = ctx.request.body
  if (ctx.session.user) {
    result = {
      errno: 2
    }
  } else {
    let user = await check(username, password)
    if (user) {
      result = {
        errno: 0,
        user
      }
      ctx.session.user = user
    } else {
      result = {
        errno: 1
      }
    }
    console.log(user.nickname + ' login')
  }
  ctx.body = result
})

module.exports = router
