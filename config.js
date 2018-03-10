const brew = require('./node_lib/brew_packages')
const cask = require('./node_lib/brew_casks')
const npm = require('./node_lib/npm_packages')

module.exports = {
  brew: brew,
  cask: cask,
  npm: npm
};
