// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// MANUALLY PUT EVERY JAVASCRIPT
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require selectize.js
//= require foundation
//= require googlemaps120714.js
//= require locationpicker.jquery.js
//= require file-validator.js
//= //require jquery.validate
//= //require jquery.validate.additional-methods
//= require jquery.sapling.min
//= require parsley
//= //require turbolinks // CAUSES ERROR
//= //require_tree .  // CAUSES ERROR


$(function(){ $(document).foundation(); });

$(document).ready(function(){

    $(function() {
        $( document ).tooltip();
    });

    $('#side-nav').sapling();
    $('#side-nav').data('sapling').expand();

    $('#expand_all').click(function() {
        $('#side-nav').data('sapling').expand();
    });

    $('#collapse_all').click(function() {
        $('#side-nav').data('sapling').collapse();
    });

    var navigationDisplay = true;
    var sideNavigationContainerCSS = $('#side-navigation-container').attr("style");
    var navigationLabelContainerCSS = $('#navigation_label_container').attr("style");

    $('#hide_show_all').click(function() {
        $('#side-nav').toggle()
        $('#search_system').toggle()
        $('#navigation_label').toggle()
        $('#expand_all').toggle()
        $('#collapse_all').toggle()

        if(navigationDisplay == true)
        {
            $('#side-navigation-container').css("width","50px");
            $('#navigation_label_container').attr("style","")
            navigationDisplay = false;
        }
        else
        {
            $('#side-navigation-container').attr("style",sideNavigationContainerCSS)
            $('#navigation_label_container').attr("style",navigationLabelContainerCSS)
            navigationDisplay = true;
        }

    });

});
