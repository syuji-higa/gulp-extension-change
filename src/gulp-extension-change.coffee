through = require 'through2'
{ File } = require 'gulp-util'
fs = require 'fs'

module.exports = (options) ->

  if options.copy is undefined
    options.copy = true

  transform = (file, encode, callback) ->

    beforeFilePath = file.path
    filePathArr = beforeFilePath.match /(^.+)(\..+$)/
    afterFilePath = "#{filePathArr[1]}.#{options.afterExtension}"

    file = new File
      path: afterFilePath
      contents: new Buffer file.contents, 'utf-8'

    @push file

    unless options.copy
      fs.unlink beforeFilePath, (err) ->
        if err then console.log "successfully deleted #{beforeFilePath}"

    callback()

  # flush = (callback) ->
  #   callback()

  return through.obj transform#, flush
