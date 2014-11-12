var manifest = require('./../package');
var requirejs = require('requirejs');
var config = {
    baseUrl:'./js-src',
    paths : {},
    name:manifest.moduleName,
    out:'./js/'+manifest.moduleName+'-min.js',
    wrap: {
        end: "define(['"+manifest.moduleName+"'],function(_){return _;});"
    },
    generateSourceMaps:true,
    preserveLicenseComments:false,
    optimize:"uglify2"
};
config.paths[manifest.moduleName] = "main";
requirejs.optimize(config);