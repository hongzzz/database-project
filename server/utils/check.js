const {query} = require('./db')

let check = async function (username, password) {
  try {
    let result = await query(`call login("${username}","${password}");`)
    // console.log(result[0][0])
    return result[0][0]
  } catch (e) {
    console.log(e.sqlMessage)
    return false
  }
}

module.exports = check
