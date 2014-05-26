module.exports = (grunt) ->
	
	grunt.initConfig(
		pkg: grunt.file.readJSON 'package.json'

		jade: 
			options: 
				pretty: false

			partials: 
				files: [
					expand: true
					cwd: 'src/views/partials/'
					src: ['*.jade']
					dest: 'public/partials/'
					ext: '.html'
				]

			root: 
				files: 
					'public/index.html': 'src/views/index.jade'

		uglify: 
			options:
				banner: '/*!build: <%= grunt.template.today("yyyy-mm-dd hh:MM:ss") %>*/'
				separator: '\n\n'

			build: 
				files: [
					expand: true
					cwd: 'src/js/'
					src: ['**/*.js']
					dest: 'public/javascripts/'
					ext: '.js'
				]

		concat: 
			options: 
				separator: '\n\n'

			js: 
				src: [
					'src/js/**/*.js'
				]
					
				dest: 'public/javascripts/busi.js'

		htmlmin:
			options:
		        removeComments: true,
		        collapseWhitespace: true

			tpl:
				files: [
					expand: true
					cwd: 'src/tpl/'
					src: ['**/*.tpl']
					dest: 'public/javascripts/app/tpl/'
				]

			json: 
				files: [
					expand: true
					cwd: 'src/test/'
					src: ['**/*.json']
					dest: 'public/test/'
				]

		sass:
			options:
				quiet: false
				trace: true
				noCache: true
				style: 'compressed'
			dist: 
				files:
					# 'public/stylesheets/style.min.css': 'src/css/main.scss'
					'public/stylesheets/calendar.min.css': 'src/css/calendar.scss'
					'public/stylesheets/cssgrids.min.css': 'src/css/cssgrids.scss'

		watch:
			sass:
				files: 'src/css/**/*.scss'
				tasks: ['sass']

			scripts:
				files: ['src/js/**/*.js']
				tasks: ['uglify']

			htmlmin:
				files: ['src/tpl/**/*.tpl', 'src/test/**/*.json']
				tasks: ['htmlmin']
	)

	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-htmlmin'
	grunt.registerTask 'default', ['watch']
	grunt.registerTask 'all', ['sass', 'uglify', 'htmlmin', 'jade']