/**
 * Created by comdiv on 12.11.2014.
 */

var olddir = process.cwd();
process.chdir(__dirname);
var requiretc = true;
if(process.argv[1].match(/gulp\.js/)){
    requiretc = false;
}
var requirejs = require("requirejs");
requirejs.undef();
var package = require("../package.json");
requirejs.define("package",[], function () {
    return package;
});
requirejs.config({
    baseUrl:__dirname
});

requirejs(["testmap"],function($tests) {

    requirejs.config({
        baseUrl : "../tests/",
        nodeRequire: require,
        paths: {
            "mocha" :"../lib/mocha",
            "chai" :"../lib/chai",
            "moment" :"../lib/moment",
            "angular" : "../lib/angular",
            "teamcity" : "../lib/teamcity",
            "angular-mocks" : "../lib/angular-mocks"
        },
        deps: ["mocha", "chai", "teamcity","moment"],
        callback: function () {

            global.location = {};
            if(requiretc) {
                var tc = requirejs("teamcity");
                mocha.setup({
                    ui: "bdd", ignoreLeaks: true, reporter: function (runner) {
                        new tc(Mocha.reporters.Base, runner);
                    }
                });
            }else{
                Mocha.process.stdout = process.stdout;
                mocha.setup({
                    ui: "bdd", ignoreLeaks: true, reporter:"spec"
                });
            }
            var profile = {node:true};
            profile.context = process.argv.join(" ");
            var req = $tests(profile);

            requirejs (req,function() {
                process.chdir(olddir);
                mocha.run();
            });
        }
    });
});

