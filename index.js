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
    config['limit'] || 50,
    (item, callback) => {
      cmd = '. lib_sh/echos.sh && . lib_sh/requirers.sh && require_'+type+' ' + item 
      dir = __dirname
      console.log(`${item}`)
      command(cmd, __dirname, callback)
    }
  );
}

installPackages('brew')
installPackages('cask')
installPackages('npm')
