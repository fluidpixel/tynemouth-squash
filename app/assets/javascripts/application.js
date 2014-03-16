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
*/

$.ajaxSetup ({
    // Disable caching of AJAX responses
    cache: false
});

$( "html" ).click(function() 
{
	$.cookie('scroll', $(window).scrollTop());
});


$(window).load(function()
{
     $("html,body").animate({scrollTop: $.cookie('scroll')}, 0);
})

function treatAsUTC(date) {
    var result = new Date(date);
    result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
    return result;
}

function updateDays(expDate, inst) {
    var now = new Date();
    var startDate = now.toDateString('dd/MM/yyyy');
    var expire = new Date(expDate);
    var endDate = expire.toDateString('dd/MM/yyyy');
    var millisecondsPerDay = 24 * 60 * 60 * 1000;
    var totalDays = (treatAsUTC(endDate) - treatAsUTC(startDate)) / millisecondsPerDay;
    $('#tbAddDays').val(totalDays);
	window.location = '/?day=' + totalDays;
}

jQuery(function($){
	$('#select_date').datepicker({minDate: 0, maxDate: +21, dateFormat: "dd/mm/yy", 
	    onSelect: function(dateText, inst) {
			var newDate = dateText.slice(0,2);
			var newMonth = dateText.slice(3,5);
			//if (newMonth < "10") { newMonth = ("0" + newMonth.slice(0,1));};
			var newYear = dateText.slice(6,11);
			var expDate = newMonth + "/" + newDate + "/" + newYear;
			updateDays(expDate, inst);}
	});
});

jQuery(function($){
	$('#select_admin_date').datepicker({dateFormat: "dd/mm/yy",
	    onSelect: function(dateText, inst) { 
			var newDate = dateText.slice(0,2);
			var newMonth = dateText.slice(3,5);
			//if (newMonth < "10") { newMonth = ("0" + newMonth.slice(0,1));};
			var newYear = dateText.slice(6,11);
			var expDate = newMonth + "/" + newDate + "/" + newYear;
			updateDays(expDate, inst);}
	});
});

function show(id) {
	if ( document.getElementById(id).style.visibility == 'visible')
	  document.getElementById(id).style.visibility = 'hidden';
	else
	 document.getElementById(id).style.visibility = 'visible';
};

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