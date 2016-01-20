window.Parsley
    .addValidator('time_order_base_rate', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var timein = $("#base_rate_start_of_effectivity").val();
            var timeout = $("#base_rate_end_of_effectivity").val();
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