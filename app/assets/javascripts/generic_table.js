$(document).ready(function(){

    $(".generic_table > tbody > tr").hover(
        function(){$(this).find("td.actions > *").css("visibility", "visible");},
        function(){$(this).find("td.actions > *").css("visibility", "hidden");})

    $("a[tooltip = 'Edit']").qtip
    ({content: 'Edit'})

    $("a[tooltip = 'Delete']").qtip
    ({content: 'Delete'})

    $("a[tooltip = 'Examine']").qtip
    ({content: 'Examine'})

});