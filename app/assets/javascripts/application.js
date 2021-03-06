// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require moment
//= require handlebars
//= require_tree .


var linkPushState = function(url, callback, ajax) {
  ajax = typeof ajax !== 'undefined' ? ajax : true;
  if(ajax && typeof callback != 'undefined') {
    $.get(url, function (data) {
      history.pushState({}, document.title, url);
      callback(data);
    });
  } else {
    history.pushState({}, document.title, url);
    callback();
  }
};
