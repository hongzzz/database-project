module.exports = {
  env: {
    "node": true,
  },
  extends: "standard",
  rules: {
    'new-cap': ["error", {"newIsCap": false, "properties": false}],
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow async-await
    'generator-star-spacing': 0
  }
}