const {query} = require('./db')

let addAccount = async function (username, nickname, password) {
  try {
    let res = await query(`call create_user("${username}","${password}","${nickname}");`)
    return res[0][0]
  } catch (e) {
    console.log(e.sqlMessage)
    return false
  }
}

module.exports = addAccount
