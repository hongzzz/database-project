const koa = require('koa')
const path = require('path')
const cor = require('koa2-cors')
const bodyParser = require('koa-bodyparser')
const session = require('koa-session')
const koa_static = require('koa-static')
const app = new koa()

const server = require('http').Server(app.callback())

const login = require('./routes/login')
const logout = require('./routes/logout')
const ifLogin = require('./routes/ifLogin')
const register = require('./routes/register')
const getsession = require('./routes/getsession')
const gettopic = require('./routes/gettopic')
const getreply = require('./routes/getreply')
const addreply = require('./routes/addreply')
const addtopic = require('./routes/addtopic')
const changeuserinfo = require('./routes/changeuserinfo')

app.keys = ['secret']

app.use(cor({
  origin: 'http://172.29.35.3:8080',
  credentials: true
}))
app.use(bodyParser())
app.use(session(app))

const staticPath = './static'

app.use(koa_static(
  path.join(__dirname, staticPath)
))

// calculate time
app.use(async (ctx, next) => {
  const start = new Date()
  await next()
  const ms = new Date() - start
  console.log(`${ctx.method} ${ctx.url} - ${ms}ms`)
})

// routes
app.use(login.routes()).use(login.allowedMethods())
app.use(logout.routes()).use(logout.allowedMethods())
app.use(ifLogin.routes()).use(ifLogin.allowedMethods())
app.use(register.routes()).use(register.allowedMethods())
app.use(getsession.routes()).use(getsession.allowedMethods())
app.use(gettopic.routes()).use(gettopic.allowedMethods())
app.use(getreply.routes()).use(getreply.allowedMethods())
app.use(addreply.routes()).use(addreply.allowedMethods())
app.use(addtopic.routes()).use(addtopic.allowedMethods())
app.use(changeuserinfo.routes()).use(changeuserinfo.allowedMethods())

// start server at 3000
server.listen(3000, () => {
  console.log('start server at http://localhost:3000')
})
