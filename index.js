const emoji = require('node-emoji')
const fs = require('fs')
const inquirer = require('inquirer')
const async = require('async')
const config = require('./config')
const command = require('./lib_node/command')

const installPackages = function(type){
  console.info(emoji.get('coffee'), ' installing '+type+' packages')

  async.eachLimit(
    config[type],
    1,
    function(item, callback) {
      console.info(type+':', item)
      command('. lib_sh/echos.sh && . lib_sh/requirers.sh && require_'+type+' ' + item, __dirname, function(err, out) {
        if(err) console.error(emoji.get('fire'), err)
      })
      console.info(item + ' installed')
      callback();
    },
    function(err) {
      if (err) {
        console.info('FAILURE')
      } else {
        console.info('All packages downloaded successfully')
      }
    }
  )
}

installPackages('brew')
installPackages('cask')
installPackages('npm')
