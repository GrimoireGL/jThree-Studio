var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var fs = require('fs');
var path = require('path');
var Promise = require('bluebird');
var _ = require('lodash');
var coffee = require('gulp-coffee');
var runSequence = require('run-sequence');

gulp.task('build', function () {
  runSequence('compile-coffee', 'browserify');
});

gulp.task('watch', ['build'], function () {
  gulp
    .watch('./assets/coffee/**/*.coffee', ['build'])
    .on('change', function (evt) {
      console.log('File ' + evt.path + ' was ' + evt.type + '. watching.');
    });
});

gulp.task('browserify', function () {
  readDir('./.tmp/gulp-temp/js/').then(function (fileList) {
    // console.log(fileList.map(function (file) { return './.tmp/gulp-temp/js/' + file; }))
    browserify({
      entries: fileList.map(function (file) { return './.tmp/gulp-temp/js/' + file; })
    })
    .bundle()
    .pipe(source('bundle.js'))
    .pipe(gulp.dest('assets/js/'));
  });
});

gulp.task('compile-coffee', function() {
  return gulp.src('./assets/coffee/**/*.coffee').pipe(coffee()).pipe(gulp.dest('./.tmp/gulp-temp/js/'));
});


function readDir(relativePath, seekDirAry) {
  seekDirAry = seekDirAry || [];
  return new Promise(function (resolve, reject) {
    fs.readdir(relativePath, function(err, files){
      if (err) reject(err);
      var data = [];
      files.forEach(function(file) {
        var files = new Promise(function (resolve_, reject_) {
          if (fs.statSync(path.resolve(__dirname, relativePath+file)).isDirectory()) {
            var targetDir = relativePath + file + '/';
            Promise.all(readDir(targetDir, seekDirAry.concat([file]))).then(function (filepaths) {
              resolve_(filepaths);
            });
          } else {
            dir = _.isEmpty(seekDirAry) ? '' : seekDirAry.join('/') + '/';
            resolve_([dir + file]);
          }
        });
        data.push(files);
      });
      Promise.all(data).then(function (d) {
        resolve(_.flatten(d));
      })
    });
  });
}
