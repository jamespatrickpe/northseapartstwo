window.Parsley
    .addValidator('range_institutional_adjustment', {
        requirementType: 'string',
        validateString: function(value, requirement)
        {
            var start_range = parseInt($("#institutional_adjustment_start_range").val());
            var end_range = parseInt($("#institutional_adjustment_end_range").val());
            if( (start_range > end_range) )
            {
                return false
            }
            else
            {
                return true
            }
        },
        messages: {
            en: 'Invalid Range Input. Range is backwards.'
        }
    });