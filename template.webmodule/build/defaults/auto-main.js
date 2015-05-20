/**
 /**
 * Created by comdiv on 17.11.2014.
 */
var myModule = ""; // set module manually if automatic response from HREF is not valid

var useThe = true; //set to true if module uses THE library
var useTotalLeaflet = true; //set to true if module uses TOTALLEAFLET
var useUiBootstrap = false; //set to true if module uses UIBOOTSTRAP
var useAllPerformance = false; //set to true to load all useBindonce, useScalyr, useReact
var useBindonce = useAllPerformance || false; // set to true to load bindonce 
var useScalyr = useAllPerformance || false; // set to true to load scalyr
var useReact = useAllPerformance || false;
var useDatetimePicker = true;


if (!myModule) {
    myModule = document.location.href.match(/\/([^\/]+)\.html/)[1];
}


var ver = document.querySelector('html').getAttribute("ui-version") || "0.1";
require.config({
    urlArgs: ver
});
if (!myModule) {
    myModule = document.location.href.match(/\/([^\/]+)\.html/)[1];
}
var myScript = document.querySelector('head script[data-main]');
if (myScript) {
    var mod = myScript.getAttribute("module");
    if(mod){
        myModule = mod;
    }
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

var main = myModule;
var base = "./js";
if (document.location.href.match(/debug/)) {
    main = myModule;
}
if (document.location.href.match(/src/)) {
    main = myModule;
    base = "../src/js";
}

var config = {
    baseUrl: base,
    deps: [myModule],
    paths:{},
    shim:{},
    callback: function () {

        var deps = [];
        deps.push(myModule);

        if (useThe) {
            deps.push("the-all");
        }
        if (useUiBootstrap) {
            deps.push("ui.bootstrap");
        }

        if(useBindonce){
            deps.push("pasvaz.bindonce");
        }
        if(useScalyr){
            deps.push("sly");
        }

        if(useReact){
            require(["react"],function(r){
                window.React = r;
            });
        }

        // bind additional Angular modules for bootstrap here
        angular.bootstrap(document, deps);
    }
};
config.paths[myModule] = main;
config.shim[myModule] = {deps: ["angular"]};
if(useBindonce){
    config.shim["bindonce"] = {deps: ["angular"]};
    config.shim[myModule].deps.push("bindonce");
}
if(useScalyr){
    config.shim["scalyr"] = {deps: ["angular"]};
    config.shim[myModule].deps.push("scalyr");
}
if(useReact){
    config.shim["react"] = {deps: ["angular"]};
    config.shim[myModule].deps.push("react");
}
if(useDatetimePicker){
    config.paths.datetimepicker = "jquery.datetimepicker";
    config.shim["datetimepicker"] = {deps: ["jquery"]};
    config.shim[myModule].deps.push("datetimepicker");
}

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