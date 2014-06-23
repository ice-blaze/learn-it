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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require highlight.pack
//= require_tree .

$(function(){
    $(document).foundation();
    $('pre').each(function(i, e) {hljs.highlightBlock(e)});
});




function regexTester(callElement, regexId) {
    var regex = document.getElementById(regexId).value;

    var re = new RegExp(regex);
    if (callElement.value.match(re)) {
        callElement.className = " regex-validate";
    } else {
        callElement.className = " regex-error";
    }
}

$('.arrow-up').bind('ajax:complete', function() {
    $('.accordion').load();
});