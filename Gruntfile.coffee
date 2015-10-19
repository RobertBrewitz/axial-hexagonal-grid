"use strict"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: "package.json"
    concat:
      options:
        seperator: ";"
      dist:
        src: ["src/**/*.js"]
        dest: ["dist/js/<%= pkg.name %>-<%= pkg.version %>.js"]
    watch:
      coffee:
        files: ["**/*.coffee"]
        tasks: ["coffee", "jasmine"]
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
  grunt.registerTask "default", ["watch"]

