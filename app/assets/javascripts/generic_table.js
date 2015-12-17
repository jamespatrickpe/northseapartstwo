// deletable item confirmation
$(function() {
    $('.delete_item').click(function(e) {
        e.preventDefault();
        if (window.confirm("Are you sure?")) {
            location.href = this.href;
        }
    });
});

// For generic_table
$(document).ready(function(){

    $(".generic_table > tbody > tr").hover(
        function(){$(this).find("td.actions > *").css("visibility", "visible");},
        function(){$(this).find("td.actions > *").css("visibility", "hidden");})

    $("a[tooltip = 'Edit']").qtip
    ({content: 'Edit'})

    $("a[tooltip = 'Delete']").qtip
    ({content: 'Delete'})

});