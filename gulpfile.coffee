gulp = require("gulp")
coffee = require("gulp-coffee")

require "coffee-script/register"

gulp.task "default", ->
gulp.task "build", ->
    gulp.src("src/**/*.coffee")
        .pipe(coffee(bare:true))
        .pipe(gulp.dest("./dist"))
