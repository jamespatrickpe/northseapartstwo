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
// Place javascripts here that are needed application wide.
//
// Manually put every javascript
//= require jquery
//= require jquery-ui
//= require selectize.js
//= require locationpicker.jquery.js
//= require file-validator.js
//= require jquery.validate
//= require jquery.sapling.min
//= require parsley
//= require export_to_csv
//= require jquery.autocomplete.min
//= require generic_table.js
//= require foundation
//= require jquery.qtip.min.js
//= require employee_quick_profile.js
//= require moment.js

$(document).foundation();
$(document).foundation('alert','events');

// For Contact Details
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

$(document).ready(function()
{
    $( "[title]").mouseover(function(){
        tooltip = "<div style='z-index: 10;'></div>"
    });
});

$(function() {
    $('.deletable_item').click(function(e) {
        e.preventDefault();
        if (window.confirm("Are you sure you want to delete this item?")) {
            location.href = this.href;
        }
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

window.Parsley
    .addValidator('time_between_attendance', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var employee_id = $("#attendance_employee_id_"+requirement).val();
            var date = $("#attendance_date_"+requirement).val();
            var response = ''
            $.ajax({
                method: "POST",
                url: "/application/check_time_if_between_attendance",
                data: { time: value, employee_id: employee_id, date: date },
                async: false
            }).done(function( msg ) {
                if(msg == 'false')
                {
                    response = true;
                }
                else
                {
                    response = false;
                }
            });
            return response;
        },
        messages: {
            en: 'Time has already been occupied by a previous Attendance Record.'
        }
    });

window.Parsley
    .addValidator('time_order_attendance', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var timein = $("#attendance_timein_"+requirement).val();
            var timeout = $("#attendance_timeout_"+requirement).val();
            if( (timein > timeout) && timein != '' && timeout != '')
            {
                return false
            }
            else
            {
                return true
            }
        },
        messages: {
            en: 'Invalid time Input. Time is backwards.'
        }
    });

window.Parsley
    .addValidator('date_precedence', {
        requirementType: 'string',
        validateString: function() {
            var leaveFrom = new Date($("#leave_start_of_effectivity").val()).getTime();
            var leaveTo = new Date($("#leave_end_of_effectivity").val()).getTime();
            if (leaveFrom < leaveTo){

                console.log(leaveFrom + '----------' + leaveTo + ' inside valid')
                return true
            } else {
                console.log(leaveFrom + '----------' + leaveTo + ' inside invalid')
                return false
            }
        },
        messages: {
            en: 'Please make sure selected START date comes before END date.'
        }
    });

window.Parsley
    .addValidator('leave_date_overlap', {
       requirementType: 'string',
        validateString: function() {
            var start_of_effectivity = new Date($("#leave_start_of_effectivity").val()).getTime();
            var end_of_effectivity = new Date($("#leave_end_of_effectivity").val()).getTime();
            var employee_id = $("#leave_employee_id").val();
            var response = ''

            {
                $.ajax({
                    method: "POST",
                    url: "/application/check_leave_date_if_overlap",
                    data: { start_of_effectivity: start_of_effectivity, end_of_effectivity: end_of_effectivity, employee_id: employee_id },
                    async: false
                }).done(function( msg ) {
                    if(msg == 'true')
                    {
                        response = true;
                    }
                    else
                    {
                        response = false;
                    }
                });
                return response;
            }

        },
        messages: {
            en: 'Person already has leaves filed within the selected date. Please double check.'
        }

    });

window.Parsley
    .addValidator('time_overlap_attendance', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var timein = $("#attendance_timein_"+requirement).val();
            var timeout = $("#attendance_timeout_"+requirement).val();
            var date = $("#attendance_date_"+requirement).val();
            var employee_id = $("#attendance_employee_id_"+requirement).val();
            var response = ''
            if ( timein != '' && timeout != '' )
            {
                $.ajax({
                    method: "POST",
                    url: "/application/check_time_if_overlap_attendance",
                    data: { timein: timein, timeout: timeout, date: date, employee_id: employee_id },
                    async: false
                }).done(function( msg ) {
                    if(msg == 'false')
                    {
                        response = true;
                    }
                    else
                    {
                        response = false;
                    }
                });
                return response;
            }
        },
        messages: {
            en: 'Invalid time Input. Time overlaps with a previous Attendance Record.'
        }
    });

