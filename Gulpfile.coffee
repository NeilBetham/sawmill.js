# Load all required libraries.
gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
gutil      = require 'gulp-util'
rename     = require 'gulp-rename'

# Compile all the src coffee script into dist dir
gulp.task 'coffeescript', ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee(bare: true).on 'error', gutil.log
    .pipe concat 'sawmill.js'
    .pipe gulp.dest 'dist'
    .pipe uglify()
    .pipe rename 'sawmill.min.js'
    .pipe gulp.dest 'dist'


gulp.task 'watch', ->
  gulp.watch 'src/**/*.coffee', ['coffeescript']

# Default task
gulp.task 'default', ['coffeescript']
