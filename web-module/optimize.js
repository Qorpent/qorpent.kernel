var manifest = require('./package');
var requirejs = require('requirejs');
var config = {
    baseUrl:'./js-src',
    paths : {},
    name:manifest.moduleName,
    out:'./js/'+manifest.moduleName+'-min.js'
};
config.paths[manifest.moduleName] = "main";
requirejs.optimize(config);