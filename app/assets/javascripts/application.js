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
// Manually put every javascript
//= require jquery
//= // require jquery_ujs
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
//= require jquery.dataTables
//= require jquery-tablesorter
//= require jquery-tablesorter/jquery.tablesorter
//= require jquery-tablesorter/jquery.tablesorter.widgets
//= require jquery-tablesorter/addons/pager/jquery.tablesorter.pager
//= require jquery-tablesorter/widgets/widget-repeatheaders
//= require jquery-tablesorter/parsers/parser-metric
//= require jquery-tablesorter/extras/jquery.quicksearch
//= require jquery-tablesorter/jquery.metadata
//= //require turbolinks // CAUSES ERROR
//= //require_tree .  // CAUSES ERROR


//$(function(){ $(document).foundation(); });

$(document).foundation();
$(document).foundation('alert','events');

function GetURLParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++)
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam)
        {
            return sParameterName[1];
        }

    }
}

function convertSQLTimeToHTML5Input(myDate)
{
    var date = new Date(myDate);
    var currentDateOne = (date.toISOString())
    var currentDateTwo = currentDateOne.substring(0, (currentDateOne.length)-5);
    return currentDateTwo;
}

$(document).ready(function(){
    $(".deletable_item").click(function(){
        return confirm("Are you sure you want to delete this item?");
    });
});

//Validates if username already exists in Database
window.Parsley.addAsyncValidator('validate-username', function (xhr)
{
    //alert(xhr.status);
    var obj = $.parseJSON(xhr.responseText);
    var usernameField = $("#username").parsley();
    if (obj['exists'] == false)
    {
        window.ParsleyUI.removeError(usernameField, "myCustomError");
        return true;
    }
    else if (obj['exists'] == true)
    {
        window.ParsleyUI.removeError(usernameField, "myCustomError");
        window.ParsleyUI.addError(usernameField, "myCustomError", 'Username already exists');
        return false;
    }
    else
    {
        window.ParsleyUI.addError(usernameField, "myCustomError", 'Cannot Connect to Database');
        return false;
    }
}, '/application/check_username_exists');

//Validates if email already exists in Database
window.Parsley.addAsyncValidator('validate-email', function (xhr)
{
    //alert(xhr.status);
    var obj = $.parseJSON(xhr.responseText);
    var emailField = $("#email").parsley();
    if (obj['exists'] == false)
    {
        window.ParsleyUI.removeError(emailField, "myCustomError");
        return true;
    }
    else if (obj['exists'] == true)
    {
        window.ParsleyUI.removeError(emailField, "myCustomError");
        window.ParsleyUI.addError(emailField, "myCustomError", 'Email already exists');
        return false;
    }
    else
    {
        window.ParsleyUI.addError(emailField, "myCustomError", 'Cannot Connect to Database');
        return false;
    }
}, '/application/check_email_exists');

