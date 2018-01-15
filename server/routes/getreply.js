const router = require('koa-router')()
const {query} = require('../utils/db')

router.prefix('/getreply')

router.post('/', async (ctx, next) => {
  let result = {}
  let {tid} = ctx.request.body
  try {
    let res = await query(`select content,nickname,createtime,avatar from reply,user 
    where user.uid=reply.uid and tid=${tid}
    order by createtime desc;`)
    result = res
  } catch (e) {
    console.log(e.sqlMessage)
    result = {}
  }
  ctx.body = result
})

module.exports = router
