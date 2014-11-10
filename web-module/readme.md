= Qorpent HOST Web Module Template

.dir in most folders - method to keep project structure with empty folders in git

/bxls				-- BXLS source files
  |_ init.bxls		-- basic source file for B#, core imports here
/cs					-- Generated C# files from B# will be here
/css 				-- CSS's folder for production
/css-src			-- CSS's folder for debug CSS generation
/demo				-- samples, demo pages place here
/fonts				-- font's assets folder
/img 				-- Image's assets folder, including Compass sprite generated files
/js					-- JS production folder (minimized versions)
/js-src				-- JS source folder (source versions)
  |_ main.js 		-- special JS module to be compiled for minimization
/lib 				-- place external/system JS/css here
  |_ *.*			-- default set of modules  - require, mocha/chai, angular, required almost for any web module
/tests				-- JS/css testing folder
/scss				-- SCSS sources folder
/views				-- ANGULAR views folder
build.sh			-- shell build run for all tasks (bsc, compass, optimize)
build.bsproj		-- project file for B# part of module
config.rb 			-- compass configuration 
optimize.js			-- node.js requirejs optimization call
package.json		-- node.js configuration and defaults for optimize.js, build.bsproj
.gitignore			-- .gitignore file by default
