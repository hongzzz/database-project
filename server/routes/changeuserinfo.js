const router = require('koa-router')()
const {query} = require('../utils/db')

router.prefix('/changeuserinfo')

router.post('/', async (ctx, next) => {
  let result = {}
  let {uid, nickname, email, sex} = ctx.request.body
  try {
    let res = await query(`update user set nickname="${nickname}",email="${email}",sex=${sex} where uid=${uid}`)
    let user = await query(`select * from user where uid=${uid}`)
    console.log(user)
    result = user[0]
    ctx.session.user = user[0]
  } catch (e) {
    console.log(e.sqlMessage)
    result = {}
  }
  ctx.body = result
})

module.exports = router
