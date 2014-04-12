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

//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.ui.slider
//= require jquery.cookie
//= require chosen-jquery
//= require scaffold
//= require_tree .

$(document).ready(function () {
    /*
     * Removes the flash message
     */
    $(".flashbox .close").click(function () {
        $(this).parent().slideUp();
    });

    /*
     * Calls a jquery ui datetimepicker
     */
    $('.datetimepicker').datetimepicker({
        dateFormat: "yy-mm-dd",
        timeFormat: "HH:mm:00"
    });

    var loadToggleState = function () {
        var mycookie = $.cookie($(this).attr('id'));
        if (mycookie && mycookie == "true") {
            $(this).prop('checked', mycookie);
        }
    };
    var saveToggleState = function () {
        $.cookie($(this).attr('id'), $(this).prop('checked'), {
            path: '/',
            expires: 365
        });
    };

    $("#toggle-promotions").each(loadToggleState);
    $("#toggle-promotions").change(saveToggleState);
    $("#toggle-students").each(loadToggleState);
    $("#toggle-students").change(saveToggleState);
    $("#toggle-followers").each(loadToggleState);
    $("#toggle-followers").change(saveToggleState);
});