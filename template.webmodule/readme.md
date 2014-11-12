= Qorpent HOST Web Module Template

.dir in most folders - method to keep project structure with empty folders in git

package.json		-- node.js configuration and defaults for optimize.js, build.bsproj
make.sh			    -- shell runner for targets
bld				    -- sh shortcut for build.sh build all
bld.cmd			    -- cmd shortcut for build.sh build all

/dist               -- distribution module files
  |_ /css 			-- CSS's folder for production
  |_ /fonts			-- font's assets folder
  |_ /img 		    -- Image's assets folder, including Compass sprite generated files
  |_ /js			-- JS production folder (minimized versions)
  |_ /views			-- ANGULAR views folder
  |_ /wiki          -- distribution level WIKI

/src                -- directory for sources to be just raw for compilation
  |_ /js			-- JS/TypeScript source folder (source versions of JS and TypeScript)
  |_ /bxls			-- BXLS source files
  |_ /cs			-- C# files
    |_ /auto        -- auto generated C# from B#
  |_ /css		    -- CSS/SCSS folder for  generation

/tests				-- JS/css testing folder

/lib 				-- place external/system JS/css here
  |_ *.*			-- default set of modules  - require, mocha/chai, angular, required almost for any web module

/demo				-- samples, demo pages place here

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
  |_ main.js 		-- special JS module to be compiled for minimization by default

.gitignore			-- .gitignore file by default
