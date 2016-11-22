through = require 'through2'
{ File } = require 'gulp-util'
{ assign, clone } = require 'lodash'
fs = require 'fs'

module.exports = (opts) ->
  transform = (file, encode, callback) ->

    beforeFilePath = file.path
    filePathArr    = beforeFilePath.match /(^.+)(\..+$)/
    afterFilePath  = "#{filePathArr[1]}.#{opts.afterExtension}"

    file.path     = afterFilePath
    file.contents = new Buffer file.contents, 'utf-8'

    @push file

    callback()

  return through.obj transform
