const router = require('koa-router')()
const {query} = require('../utils/db')

router.prefix('/gettopic')

router.post('/', async (ctx, next) => {
  let result = {}
  let {sid} = ctx.request.body
  try {
    let res = await query(`select tid,nickname,title,content,replycount,createtime,updatetime,avatar from topic,user 
    where topic.uid=user.uid and sid=${sid}
    order by updatetime desc;`)
    result = res
  } catch (e) {
    console.log(e.sqlMessage)
    result = {}
  }
  ctx.body = result
})

module.exports = router
