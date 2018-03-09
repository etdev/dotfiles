const emoji = require('node-emoji')
const fs = require('fs')
const bbPromise = require('bluebird');
const inquirer = require('inquirer')
const config = require('./config')
const command = require('./lib_node/command')

const installPackages = function(type){
  console.info(emoji.get('coffee'), ' installing '+type+' packages')
  return bbPromise.map(
    config[type],
    function(item){
      console.info(type+':', item)
      command('. lib_sh/echos.sh && . lib_sh/requirers.sh && require_'+type+' ' + item, __dirname, function(err, out) {
        if(err) console.error(emoji.get('fire'), err)
      })
    },
    { concurrency: 10 }
  );
}

installPackages('brew')
installPackages('cask')
installPackages('npm')
