const router = require('koa-router')()

router.prefix('/ifLogin')

router.post('/', async (ctx, next) => {
  let result = {}
  if (ctx.session.user) {
    result = {
      errno: 2,
      user: ctx.session.user
    }
  } else {
    result = {
      errno: 0
    }
  }
  ctx.body = result
})

module.exports = router
