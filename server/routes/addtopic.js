const router = require('koa-router')()
const {query} = require('../utils/db')

router.prefix('/addtopic')

router.post('/', async (ctx, next) => {
  let result = {}
  let {sid, uid, title, content} = ctx.request.body
  try {
    let res = await query(`call create_topic(${sid},${uid},"${title}","${content}");`)
    result = {
      errno: 0
    }
  } catch (e) {
    console.log(e.sqlMessage)
    result = {
      errno: 1
    }
  }
  ctx.body = result
})

module.exports = router
