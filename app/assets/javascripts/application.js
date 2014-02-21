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
//= require jquery.ui.autocomplete
//= require jquery.ui.datepicker
//= require jquery_ujs
//= require_tree .

/*
$(document).on('click', 'a', function(e) {
    if ($(this).attr('target') !== '_blank' && event.target.href) 
    {
        e.preventDefault();
        window.location = $(this).attr('href');
    }
});
*/
/*
(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")

$( "html" ).click(function() 
{
	$.cookie('scroll', $(window).scrollTop());
});
*/

/*
$(document).click(function (e)
{
    var container = $("#select_admin_date");
    if (container.has(e.target).length === 0)
    {
        //container.hide();
    }
});
*/