/**
 * grunt 任务构建
 * @author Allenice
 * @date 2015-09-29 15:49
 */
'use strict';

module.exports = function(grunt) {
    var htmlDir = 'html',
        styleDir = 'style';

    require('time-grunt')(grunt);

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-html-template');
    // grunt.loadNpmTasks('grunt-curl');
    // grunt.loadNpmTasks('grunt-zip');

    // 使用 libsass
    grunt.loadNpmTasks('grunt-sass');


    //载入页面导航插件
    require('./grunt/task/nav-html/index')(grunt);

    grunt.initConfig({

        // 生成总页面导航
        "nav-html": {
            options: {
                htmlname: htmlDir + "/index.html" // 生成的页面导航放在html下，并命名为 index.html
            },
            build: {
                cwd: './',
                src: [htmlDir + '/dist/**/*.html'] // 将html目录下的所有文件纳入 页面总导航中
            }
        },

        // html 模板
        html_template: {
            options: {
                locals: require('./grunt/locals.js'),
                beautify: {
                    indent_size: 4,
                    indent_char: ' ',
                    max_preserve_newlines: 0,
                    unformatted: ['script']
                }
            },
            build_html: {
                options: {
                    force: false
                },
                expand: true,
                cwd: htmlDir + "/src",
                src: "**/*.html",
                dest: htmlDir + "/dist"
            },

            // 强制全部编译
            force: {
                options: {
                    force: true
                },
                expand: true,
                cwd: htmlDir + "/src",
                src: "**/*.html",
                dest: htmlDir + "/dist"
            }
        },

        sass: {
            options: {
                sourceMap: true,
                outputStyle: 'compressed',
                // includePaths: ['style/bourbon']
            },
            compile: {
                cwd: styleDir + '/sass',
                src: '**/*.scss',
                dest: styleDir + '/css/',
                expand: true,
                ext: '.css'
            }
        },

        watch: {
            liver: {
                options: {
                    livereload: true
                },
                files: [htmlDir + '/dist/**/*.html', styleDir + '/css/**/*.css']
            },
            html: {
                files: [htmlDir + '/src/**/*.html'],
                tasks: ['html_template:build_html', 'nav-html']
            },
            sass: {
                files: [styleDir + '/sass/**/*.scss'],
                tasks: ['sass']
            }
        }
    });

    // 默认是开发模式
    grunt.registerTask('default', ['sass', 'html_template:force', 'nav-html', 'watch']);
};
