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
      all: {
        src: [
          'src/data-segment.asm',
          'src/init.asm',
          'src/main.asm',
          'compiled/procs.asm',
          'compiled/isrs.asm'
        ],
        dest: 'compiled/mup.asm',
      }
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

    clean: {
      build: {
        src: [
          'compiled/procs.asm',
          'compiled/isrs.asm'
        ],
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.registerTask('default', ['concat:procs', 'concat:isrs', 'concat:all', 'clean']);

};
