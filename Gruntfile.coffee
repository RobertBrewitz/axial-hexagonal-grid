"use strict"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: "./package.json"
    concat:
      options:
        separator: ";"
      dist:
        src: ["src/**/*.js"]
        dest: "dist/js/ahg.js"
    uglify:
      dist:
        files:
          "dist/js/ahg.min.js": ["dist/js/ahg.js"]
    jshint:
      options:
        force: true
      all: ["src/**/*.js"]
    watch:
      coffee:
        files: ["**/*.coffee"]
        tasks: ["coffee", "jshint", "jasmine"]
    coffee:
      options:
        bare: true
      sources:
        expand: true
        flatten: false
        cwd: "src/"
        src: ["**/*.coffee"]
        dest: "src/"
        ext: ".js"
      specs:
        expand: true
        flatten: false
        cwd: "spec/"
        src: ["**/*.coffee"]
        dest: "spec/"
        ext: ".js"
    jasmine:
      all:
        src: "src/**/*.js"
        options:
          specs: "spec/**/*.js"
          helpers: "spec/helpers/*.js"

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-jasmine"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.registerTask "default", ["watch"]
  grunt.registerTask "dist", ["concat", "uglify"]

