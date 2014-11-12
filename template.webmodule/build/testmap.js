/**
 * Created by comdiv on 12.11.2014.
 */
define(["package"],function(package) {
    return function(_profile) {
        var profile =  _profile || {}; //allows some custom logic based on given profile

        var paths = {
            //initialize result here
        };
        var result = [
            //initialize result here with customs
        ];

        if(package.tests){
            package.tests.forEach(function(v){
               if(typeof(v)==="string"){ //simple test reference
                   result.push(v);
               } else {
                   if(!!v.condition){ //check conditions for given context
                       if(v.condition=="browser" && !profile.browser)return;
                       if(v.condition=="!browser" && !!profile.browser)return;
                       if(v.condition=="phantom" && !profile.phantom)return;
                       if(v.condition=="!phantom" && !!profile.phantom)return;
                       if(v.condition=="node" && !profile.node)return;
                       if(v.condition=="!node" && !!profile.node)return;
                       if(!(profile.context||"").match(new RegExp(v.condition)))return;
                   }
                   if(!!v.deps){ // если определены зависимости
                       v.deps.forEach(function(v){
                          if(typeof(v)==="string"){
                              var name = v.match(/[^\/]+$/)[0];
                              var path = v.match(/^.*\/(?=[^\/]+$)/);
                              path = !!path ? path[0] : "";
                              if(path==""){
                                  if(!profile.browser && !profile.full && package.webModuleDependency && !!package.webModuleDependency[name]){
                                      path =  package.webModuleDependency[name];
                                      var reposRoot = "../../../";
                                      if(!path.match(/^((\/)|(\w\:\/)|(\.))/)){
                                          //если путь включает в себя ссылку на файл
                                          if(path.match(/[^!?](\!)|(\?)[\w\-\d]+$/)){
                                              path = path.replace(/\!/,'.webmodule/dist/js/');
                                              path = path.replace(/\?/,'.webmodule/src/js/');
                                          }else if (path.match(/^\!/)) { //нестандартный путь от репозитория, без веб-модулей
                                              path = path.substring(1);
                                          } else { // путь к файлу по умолчанию
                                              path = path.replace(/([^\/]+)$/,'$1.webmodule/dist/js/$1');
                                          }
                                          path = reposRoot+path;
                                      }
                                  }else {
                                      path = "../dist/js/" + package.moduleName + "-full";
                                  }
                              }else{
                                  path = v;
                              }
                              if(!paths[name]){
                                  paths[name] = path;
                              }
                          }
                       });
                   }
                   if (!!v.name){
                       result.push(v.name);
                   }
               }
            });
        }
        require.config({
            paths: paths
        });
        return result;
    }
});