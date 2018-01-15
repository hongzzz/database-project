const router = require('koa-router')()
const addAccount = require('../utils/addAccount')

router.prefix('/register')

router.post('/', async (ctx, next) => {
  let result = {}
  let {username, nickname, password} = ctx.request.body
  let r = await addAccount(username, nickname, password)
  if (r.res === 0) {
    result = {
      errno: 1,
      message: r.mes
    }
    console.log(result.message)
  } else {
    result = {
      errno: 0
    }
  }
  ctx.body = result
})

module.exports = router
