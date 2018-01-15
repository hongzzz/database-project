const router = require('koa-router')()
const {query} = require('../utils/db')

router.prefix('/getsession')

router.post('/', async (ctx, next) => {
  let result = {}
  try {
    let res = await query(`select * from session order by updatetime desc;`)
    result = res
  } catch (e) {
    console.log(e.sqlMessage)
    result = {}
  }
  ctx.body = result
})

module.exports = router
