module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    concat: {
      options: {
        separator: '\n',
      },
      procs: {
        src: ['src/procs/*.asm'],
        dest: 'compiled/procs.asm',
      },
      isrs: {
        src: ['src/isrs/*.asm'],
        dest: 'compiled/isrs.asm',
      },
    },

    watch: {
      scripts: {
        files: ['src/**/*.asm'],
        tasks: ['default'],
        options: {
          spawn: false,
          interrupt: true,
          debounceDelay: 1000,
        },
      },
    },

  });

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['concat:procs', 'concat:isrs']);

};
