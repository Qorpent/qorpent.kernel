= Qorpent HOST Web Module Template

.dir in most folders - method to keep project structure with empty folders in git

/targets			-- build support files to call from make.sh
  |_ build			-- sh script to run all(default),bsc,compass,optimize
  |_ clean			-- removes all auto-generated and temporary files
  |_ bsc            -- BSC compiler runner
  |_ compass        -- COMPASS compiler runner
  |_ optimize       -- RequireJS optimizer runner
  |_ tsc            -- TypeScript compiler runner
  |_ bsc.bsproj		-- project file for B# part of module
  |_ compass.rb 	-- compass configuration
  |_ optimize.js	-- node.js requirejs optimization config
/bxls				-- BXLS source files
  |_ init.bxls		-- basic source file for B#, core imports here
/cs					-- Generated C# files from B# will be here
/css 				-- CSS's folder for production
/css-src			-- CSS's folder for debug CSS generation
/demo				-- samples, demo pages place here
/fonts				-- font's assets folder
/img 				-- Image's assets folder, including Compass sprite generated files
/js					-- JS production folder (minimized versions)
/js-src				-- JS source folder (source versions of JS and TypeScript)
  |_ main.js 		-- special JS module to be compiled for minimization by default
/lib 				-- place external/system JS/css here
  |_ *.*			-- default set of modules  - require, mocha/chai, angular, required almost for any web module
/tests				-- JS/css testing folder
/scss				-- SCSS sources folder
/views				-- ANGULAR views folder


package.json		-- node.js configuration and defaults for optimize.js, build.bsproj

= Build support console commands
make.sh			-- shell runner for targets
bld				-- sh shortcut for build.sh build all
bld.cmd			-- cmd shortcut for build.sh build all


.gitignore			-- .gitignore file by default
