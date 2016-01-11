// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.Parsley
    .addValidator('vale_deduction', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var vale_amount = parseInt($("#vale_amount").val());
            var vale_amount_of_deduction = parseInt($("#vale_amount_of_deduction").val());
            if( (vale_amount_of_deduction > vale_amount))
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