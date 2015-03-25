var File, fs, through;
through = require('through2');
File = require('gulp-util').File;
fs = require('fs');
module.exports = function(options) {
  var transform;
  if (options.copy === void 0) {
    options.copy = true;
  }
  transform = function(file, encode, callback) {
    var afterFilePath, beforeFilePath, filePathArr;
    beforeFilePath = file.path;
    filePathArr = beforeFilePath.match(/(^.+)(\..+$)/);
    afterFilePath = filePathArr[1] + "." + options.afterExtension;
    file = new File({
      path: afterFilePath,
      contents: new Buffer(file.contents, 'utf-8')
    });
    this.push(file);
    if (!options.copy) {
      fs.unlink(beforeFilePath, function(err) {
        if (err) {
          return console.log("successfully deleted " + beforeFilePath);
        }
      });
    }
    return callback();
  };
  return through.obj(transform);
};
