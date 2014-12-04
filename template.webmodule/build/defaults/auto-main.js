/**
 * Created by comdiv on 17.11.2014.
 */
var myModule = ""; // set module manually if automatic response from HREF is not valid

var useThe = false; //set to true if module uses THE library
var useTotalLeaflet = false; //set to true if module uses TOTALLEAFLET
var useUiBootstrap = false; //set to true if module uses UIBOOTSTRAP


if (!myModule) {
    myModule = document.location.href.match(/\/([^\/]+)\.html/)[1];
}

if(document.location.href.match("noplugins")){
    define("_plugins",["angular"],function(){
        var result = {execute:function(){}};
        angular.module("plugins",[]).factory("plugins",[function () {
            return result;
        }]);
        return result;
    });
}

var main = myModule + "-full";
var base = "./js";
if (document.location.href.match(/debug/)) {
    main = myModule;
}
if (document.location.href.match(/src/)) {
    main = myModule;
    base = "../src/js";
}
var myScript = document.querySelector('head script[data-main]');
window._ver = 0;
if (myScript) {
    var myUrl = myScript.getAttribute("data-main");
    if (myUrl) {
        var ver = myUrl.match(/\?(.+)$/);
        if (ver) {
            window._ver = ver[1];
            require.config({
                urlArgs: ver[1]
            });
        }
    }
}
var config = {
    baseUrl: base,
    paths: {
        "mapeditor-plugins" : "mapeditor-plugins2"//"../_config/plugins/@target(mapeditor)"
    },
    deps: [myModule],
    shim : {},
    callback: function () {

        var deps = [];
        deps.push(myModule);
        if (useThe) {
            deps.push("the-all");
        }
        if (useUiBootstrap) {
            deps.push("ui.bootstrap");
        }
        // bind additional Angular modules for bootstrap here
        angular.bootstrap(document.body, deps);
    }
};
config.paths[myModule] = main;
config.shim[myModule] = {deps: []};


if (useUiBootstrap || useThe) {
    config.shim["ui-bootstrap"] = {deps: ["angular", "jquery"]};
}
if (useThe) {
    config.shim["the"] = {deps: ["ui-bootstrap", "text"]};
    config.shim[myModule].deps.push("the");
}
if (useTotalLeaflet) {
    config.shim["totalleaflet"] = {deps: ["angular"]};
    config.shim[myModule].deps.push("totalleaflet");
}


// add advanced dependency for your module with
//config.shim[myModule].deps.push( "xxxxxx" );

require.config(config);