const brew = require('./lib_node/brew_packages')
const cask = require('./lib_node/brew_casks')
const npm = require('./lib_node/npm_packages')

module.exports = {
  brew: brew,
  cask: cask,
  npm: npm
};
