const router = require('koa-router')()

router.prefix('/logout')

router.post('/', async (ctx, next) => {
  if (ctx.session.user) {
    ctx.session = null
  }
  ctx.body = {
    errno: 0
  }
})

module.exports = router
