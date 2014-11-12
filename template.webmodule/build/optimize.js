var manifest = require('./../package');
var requirejs = require('requirejs');
var config = {
    baseUrl:'./src/js',
    paths : {},
    name:manifest.moduleName,
    out:'./dist/js/'+manifest.moduleName+'.js',
    wrap: {
        end: "define(['"+manifest.moduleName+"'],function(_){return _;});"
    },
    generateSourceMaps:true,
    preserveLicenseComments:false,
    optimize:"uglify2"
};
config.paths[manifest.moduleName] = "../../build/main";
requirejs.optimize(config);