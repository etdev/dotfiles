var execSync = require('child_process').execSync;
module.exports = function _command(cmd, dir, cb) {
  execSync(
    cmd,
    { cwd: dir || __dirname },
    function(err, stdout, stderr) {
      if (err) {
        console.error(err, stdout, stderr);
      }
      cb(err, stdout.split('\n').join(''));
    }
  );
};
