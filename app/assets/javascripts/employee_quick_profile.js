function update_quick_profile(){
    var employee_ID = $('.employee_select_field').val();
    $.post( "/application/employee_overview_profile", { employee_ID: employee_ID})
        .done(function( employee_overview_profile ) {
            var obj = jQuery.parseJSON( employee_overview_profile );
            $('#employee_quick_actor_link').html( obj['actor']['name'] );
            $('#employee_quick_actor_link').attr('href', '/human_resources/employee_profile?employee_id=' + obj['id'] );
            $('#employee_quick_employee_id').html( obj['id'] );
            $('#employee_quick_actor_description').html( obj['actor']['description'] );
            $('#employee_quick_picture').attr( 'src', obj['actor']['logo']['url'] );
            $('.employee_quick_profile').fadeIn(500);
        });
}