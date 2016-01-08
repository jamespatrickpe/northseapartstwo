// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.Parsley
    .addValidator('vale_deduction', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var vale_amount = $("#vale_amount").val();
            var vale_amount_of_deduction = $("#vale_amount_of_deduction").val();
            if( (vale_amount_of_deduction > vale_amount) && vale_amount != '' && vale_amount_of_deduction != '')
            {
                return false
            }
            else
            {
                return true
            }
        },
        messages: {
            en: 'Deduction is more than the current amount'
        }
    });