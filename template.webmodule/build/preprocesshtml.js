/**
 * Created by comdiv on 05.06.2015.
 */
var p = require('path');
var fs = require('fs');
var htmlpath = p.normalize(p.resolve(__dirname + "/../src/html"));
var targetpath = p.normalize(p.resolve(__dirname + "/../dist"));
var argv = process.argv;
var watch = false;
argv.forEach(function(_){
   if(_=="--watch"){
       watch =true;
   }
});
if (!fs.existsSync(htmlpath)) {
    console.log('no html dir to process');
    process.exit(0);
}


var cache = {};

var readinclude = function(name){
    if (!cache[name]) {
        var file = p.normalize(htmlpath + "/_includes/" + name + ".html");
        if (!fs.existsSync(file)) {
            console.error("no include file " + file);
            process.exit(1);
        }
        var includecontent = fs.readFileSync(file,{encoding:'utf8'});
        cache[name] = includecontent;
    }
    return cache[name];
}


var readfiles = function(){
    var files = fs.readdirSync(htmlpath, "*.html");
    var htmlfiles = [];
    files.forEach(function (_) {
        if (_.match(/\.html$/)) {
            htmlfiles.push(_);
        }
    });
    if (htmlfiles.length == 0) {
        console.log('no files to process');
        return;
    }
    return htmlfiles;
}

var preprocess = function (content) {
    var result = content;
    if(!!result) {
        result = result.replace(/<!--include\s+([^-]+)-->/g, function (match, name) {
            return readinclude(name);
        });
    }

    return result;
}

var execute = function() {
    cache = {};
    var htmlfiles = readfiles();
    if(!htmlfiles)return;
    htmlfiles.forEach(function (_) {
        var srcfile = p.normalize(htmlpath + "/" + _);
        var trgfile = p.normalize(targetpath + "/" + _);
        fs.readFile(srcfile, {encoding: 'utf8'},function(e,src){
            var trg= "";
            if(fs.existsSync(trgfile)){

                trg = fs.readFileSync(trgfile,{encoding:'utf8'});
            }
            var preprocessed = preprocess(src);
            if(preprocessed!=trg) {
                fs.writeFile(trgfile, preprocessed, function () {
                    console.info(srcfile + " -> " + trgfile);
                });
            }else{
                console.log("notmodified "+srcfile);
            }
        });

    });
}

execute();

if(watch){
    fs.watch(htmlpath, execute);

}